import unittest
from get_next_version import get_next_version

TEST_REPO_NAME = 'tre-blueprint-test-repository'

class TestGetNextVersion(unittest.TestCase):
    """
    Test the get_next_version function.
    """
    def test_basic_run(self):
        """
        Test output as expected.
        """
        result = get_next_version(repo_name=TEST_REPO_NAME)
        values = result.split('.')
        major = int(values[0])
        minor = int(values[1])
        patch = int(values[2])
        self.assertTrue(isinstance(major, int))
        self.assertTrue(isinstance(minor, int))
        self.assertTrue(isinstance(patch, int))

    def test_suffix(self):
        """
        Test suffix added as expected.
        """
        test_version_suffix = 'a-test-version-suffix'
        result = get_next_version(
            repo_name=TEST_REPO_NAME,
            version_suffix=test_version_suffix
        )

        parts = result.split('-', maxsplit=1)
        self.assertTrue(parts[1] == test_version_suffix)
        values = parts[0].split('.')
        major = int(values[0])
        minor = int(values[1])
        patch = int(values[2])
        self.assertTrue(isinstance(major, int))
        self.assertTrue(isinstance(minor, int))
        self.assertTrue(isinstance(patch, int))
