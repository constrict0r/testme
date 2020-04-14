- *-t* (type): This parameter indicates which types of resources to
  process.

 The allowed values are:

  - a : ansible.
  - b : bats.
  - m : molecule.
  - p : pytest.
  - t : tox.
  - y : poetry.

 This parameter is empty by default.

 .. substitution-code-block:: bash

  ./|PROJECT|.sh -t abmpty