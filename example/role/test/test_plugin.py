# From root folder run: ./testme.sh.
import pytest
import unittest


@pytest.mark.usefixtures('global_variables')
class examaple_test_plugin(unittest.TestCase):

    # tests index.
    def test_test(self):
        tests_list = self.example_vars['example_module'].tests()
        assert "variable_boolean" in tests_list

    # variable_boolean.
    def test_variable_boolean_with_true(self):
        assert self.example_vars['example_module'].variable_boolean('true')

    def test_variable_boolean_with_false(self):
        assert self.example_vars['example_module'].variable_boolean('false')

    def test_variable_boolean_with_True(self):
        assert self.example_vars['example_module'].variable_boolean(True)

    def test_variable_boolean_with_False(self):
        assert self.example_vars['example_module'].variable_boolean(False)

    def test_variable_boolean_with_777(self):
        no_bol = self.example_vars['non_boolean_var']
        assert not self.example_vars['example_module'].variable_boolean(no_bol)
