# -*- coding: utf-8 -*-

"""Example plugin."""

from ansible.module_utils._text import to_text

"""
.. module:: example
    :noindex:
    :platform: Linux
    :synopsis:  Example plugin.

.. moduleauthor:: constrict0r <constrict0r@protonmail.com>
"""


class TestModule(object):
    """Test filter used as example."""

    def tests(self):
        """Define available test filters.

        Returns:
           dict: Collection of available tests filters.
        """

        return {
            'variable_boolean': self.variable_boolean
        }

    def variable_boolean(self, value):
        """Verifies if a variable is boolean or not.

        Args:
            value (str): Variable to test.

        Returns:
            bool: True if variable is of type boolean, false otherwise.
        """

        text_value = to_text(value)
        text_value = text_value.lower()

        if text_value == 'true' or text_value == 'false':
            return True

        return False
