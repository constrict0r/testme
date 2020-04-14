# From root folder run: ./testme.sh.
import pytest

from test_plugins import example


@pytest.fixture(scope='class')
def global_variables(request):
    request.cls.example_vars = {
        'boolean_var': True,
        'non_boolean_var': 777,
        'example_module': example.TestModule()
    }
