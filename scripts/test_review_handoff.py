import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch
import review_handoff as h


class HandoffTests(unittest.TestCase):
    def setUp(self):
        # Keep test writes inside the explicitly writable workspace.
        self.temp = tempfile.TemporaryDirectory(dir=Path(__file__).resolve().parents[1] / '.ozzystower')
        self.addCleanup(self.temp.cleanup)
        root = Path(self.temp.name)
        self.root_patch = patch.object(h, 'ROOT', root)
        self.root_patch.start()
        self.addCleanup(self.root_patch.stop)
        self.runs_patch = patch.object(h, 'RUNS', root / '.ozzystower' / 'reviews')
        self.runs_patch.start()
        self.addCleanup(self.runs_patch.stop)
        (root / 'sample.py').write_text('def f(): return 1\n')
        (root / 'docs' / 'orchestration').mkdir(parents=True)

    def test_unapproved_run_never_launches(self):
        folder = h.prepare(['sample.py'], 'Review correctness.')
        with patch.object(h.subprocess, 'run') as launch:
            with self.assertRaises(ValueError):
                h.run(folder, False)
            launch.assert_not_called()

    def test_changed_packet_and_source_block_launch(self):
        folder = h.prepare(['sample.py'], 'Review correctness.')
        (h.ROOT / 'sample.py').write_text('changed')
        with patch.object(h.subprocess, 'run') as launch:
            with self.assertRaises(ValueError):
                h.run(folder, True)
            launch.assert_not_called()

    def test_path_escape_and_credentials_rejected(self):
        for name in ['../outside.py', '.env']:
            with self.assertRaises(ValueError):
                h.source_file(name)
        with self.assertRaises(ValueError):
            h.screen('api_key = "' + 'not-a-real-secret-value' + '"')

    def test_capture_and_one_attempt_only(self):
        folder = h.prepare(['sample.py'], 'Review correctness.')

        def fake_process(*args, **kwargs):
            (folder / 'findings.md').write_text('No defect in supplied function.')
            events = [{'type': 'thread.started', 'thread_id': 'offline-fixture'},
                      {'type': 'turn.completed', 'usage': {'input_tokens': 10, 'output_tokens': 5}}]
            (folder / 'events.jsonl').write_text('\n'.join(json.dumps(e) for e in events))
            return type('Result', (), {'returncode': 0})()

        with patch.object(h.subprocess, 'run', side_effect=fake_process) as launch:
            self.assertEqual(h.run(folder, True), 0)
            report = json.loads((folder / 'manifest.json').read_text())
            self.assertEqual(report['usage']['input_tokens'], 10)
            self.assertIsNone(report['cost_usd'])
            self.assertTrue((folder / 'handoff.md').exists())
            with self.assertRaises(ValueError):
                h.run(folder, True)
            self.assertEqual(launch.call_count, 1)

    def test_launch_failure_still_returns_handoff_and_ledger(self):
        folder = h.prepare(['sample.py'], 'Review correctness.')
        with patch.object(h.subprocess, 'run', side_effect=OSError('offline fixture')):
            self.assertEqual(h.run(folder, True), 1)
        self.assertTrue((folder / 'handoff.md').exists())
        self.assertEqual(json.loads((folder / 'manifest.json').read_text())['status'], 'failed')
        self.assertTrue((h.ROOT / '.ozzystower/runs.jsonl').exists())

    def test_atomic_claim_blocks_second_caller(self):
        folder = h.prepare(['sample.py'], 'Review correctness.')
        (folder / 'attempt.lock').touch()
        with patch.object(h.subprocess, 'run') as launch:
            with self.assertRaises(FileExistsError):
                h.run(folder, True)
            launch.assert_not_called()


if __name__ == '__main__':
    unittest.main()
