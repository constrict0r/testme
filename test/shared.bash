# From root folder run: ./testme.sh -d.

setup() {
    # Set globals.
    CURRENT_PATH=${BATS_TEST_DIRNAME%/*}

    # Source testme script.
    source $CURRENT_PATH/testme.sh

    TEST_PATH=$(get_test_path $CURRENT_PATH)

    # Cleanup common files.
    rm -rf /tmp/testme.sh
    rm -rf /tmp/test
    rm -rf /tmp/subproject

    # Cleanup ansible files.
    rm -rf /tmp/role
    rm -rf /tmp/library
    rm -rf /tmp/test_plugins
    rm -rf ~/.ansible/roles/constrict0r.role

    # Cleanup python files.
    rm -rf /tmp/pyboom
    rm -rf /tmp/venv

    # Install all requirements.
    INSTALL_REQUIREMENT=true
    docker_setup
    ansible_setup
    bats_setup
    molecule_setup
    INSTALL_REQUIREMENT=false

    # Get python executable.
    PY_EX=$(get_python_exec)

    # Remove testuser.
    /usr/sbin/userdel testuser &>/dev/null && rm -rf /home/testuser &>/dev/null

    # Create non-sudoer testuser.
    /usr/sbin/useradd -m -d /home/testuser -g users -s /bin/bash testuser &>/dev/null

    # Kick-out testuser from sudoers group.
    run /usr/sbin/deluser testuser sudo &>/dev/null

    # Create hierarchically project infraestructure.
    mkdir -p /tmp/test
    chmod a+rwx -R /tmp/test
    mkdir -p /tmp/subproject/test

    # Copy testme script (prevents file not found on Travis-CI).
    cp -f $CURRENT_PATH/testme.sh /tmp/testme.sh
    chmod a+rwx /tmp/testme.sh

    # Copy it to child project.
    cp -f $CURRENT_PATH/testme.sh /tmp/subproject/testme.sh
    chmod a+rwx /tmp/subproject/testme.sh

    # Ansible files.
    cp -f $CURRENT_PATH/example/test-playbook.yml /tmp/test
    cp -f $CURRENT_PATH/example/test-playbook.yml /tmp/subproject/test

    # Bats files.
    cp -f $CURRENT_PATH/example/test.bats /tmp/test
    cp -f $CURRENT_PATH/example/test.bats /tmp/subproject/test

    # Pytest files.
    cp -f $CURRENT_PATH/example/test.py /tmp/test
    cp -rf $CURRENT_PATH/example/pyboom /tmp

    # Molecule files.
    cp -rf $CURRENT_PATH/example/role /tmp
}

teardown() {
    # Cleanup common files.
    rm -rf /tmp/testme.sh
    rm -rf /tmp/test
    rm -rf /tmp/subproject

    # Cleanup ansible files.
    rm -rf /tmp/role
    rm -rf /tmp/library
    rm -rf /tmp/test_plugins
    rm -rf ~/.ansible/roles/constrict0r.role

    # Cleanup python files.
    rm -rf /tmp/pyboom
    rm -rf /tmp/venv

    # Install all requirements.
    INSTALL_REQUIREMENT=true
    docker_setup
    ansible_setup
    bats_setup
    molecule_setup
    INSTALL_REQUIREMENT=false

    # Kick-out non-sudoer user from sudoers group.
    run /usr/sbin/deluser testuser sudo &>/dev/null
    sed -i '/testuser  ALL=(ALL) NOPASSWD: ALL/d' /etc/sudoers

    # Remove non-sudoer user.
    run /usr/sbin/userdel testuser &>/dev/null && rm -rf /home/testuser &>/dev/null
}
