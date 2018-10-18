"""
Utility functions for tests.
"""

import os

__THIS_DIR = os.path.dirname(os.path.abspath(__file__))


def resource_file_contents(filename: str) -> str:
    """
    Return the contents of a resource file.
    """
    with open(os.path.join(__THIS_DIR, "..", "resources", filename)) as resource_file:
        return resource_file.read()
