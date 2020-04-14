Description
--------------------------------------------------------------

Bash script to auto-discover and run all project tests, you can run the tests
on the local machine (bare metal) or inside a
`Docker container <https://www.docker.com>`_.

This script searches on a project folder for tests of the types:

- `Ansible <https://www.ansible.com>`_:

 - `Bare metal <https://is.gd/PPBfZ1>`_.

 - `Molecule <https://molecule.readthedocs.io>`_.

- `Bats <https://github.com/sstephenson/bats>`_.

- `Pytest <https://pytest.org/en/latest>`_:

 - If the **-g** parameter is present, a coverage report is generated.

- `Tox <https://tox.readthedocs.io>`_.

- `Poetry <https://python-poetry.org>`_.

Any found test is executed. The locations where this script searches for tests
are:

- Ansible:

  - Ansible modules on *./library*.

  - Ansible test plugins on *./tests_plugins*.

  - Ansible playbooks with the *-playbook* suffix on *./test* or *./tests*.

  - The folder *./molecule*.

- Bats:

  - Files with the extension *.bats* on *./test* or *./tests*.

- Pytest:

  - Files with the extension *.py* on *./test* or *./tests*.

- Tox:

  - The *./tox.ini* file.

- Poetry:

  - The *./pypoetry.yml* file.