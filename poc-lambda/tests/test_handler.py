"""
Example test for example AWS Lambda handler function.
"""
import unittest
from handler import handler

KEY_ALPHA = 'alpha'
KEY_BRAVO = 'bravo'
KEY_CHARLIE = 'charlie'

class TestExample(unittest.TestCase):
    """
    Example tests.
    """
    def test_output_valid(self):
        """
        Test output as expected.
        """
        result = handler(event=None, context=None)
        self.assertTrue(isinstance(result, dict))
        self.assertTrue(KEY_ALPHA in result)
        self.assertTrue(isinstance(result[KEY_ALPHA], dict))
        self.assertTrue(KEY_BRAVO in result[KEY_ALPHA])
        self.assertTrue(KEY_CHARLIE in result)
        self.fail('Temporary failure to test build')
