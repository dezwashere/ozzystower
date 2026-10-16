"""Harmless review fixture; not application code."""

def average(values):
    """Return the arithmetic mean, or 0 when values is empty."""
    return sum(values) / len(values)
