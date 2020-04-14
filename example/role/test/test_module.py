# From root folder run: ./testme.sh.
import pytest
import subprocess
import unittest


@pytest.mark.usefixtures('global_variables')
class example_test_module(unittest.TestCase):

    # tests run.
    def test_run(self):
        command = 'ansible-playbook '
        inventory = '-i test/inventory '
        playbook = '/tmp/role/test/test-playbook-module.yml '
        extra = '-e "ansible_python_interpreter=/usr/bin/python3"'
        ansible_command = command + inventory + playbook + extra
        subprocess.check_call(ansible_command, shell=True)
