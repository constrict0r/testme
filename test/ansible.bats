#!/usr/bin/env bats
#
# From root folder run: ./testme.sh -d.

load shared

@test "Asible run playbook." {
    run ansible_run /tmp
    [[ $output == *'hello'* ]]
}

@test "Asible run playbook on virtualenv." {
    $PY_EX -m venv /tmp/venv
    source /tmp/venv/bin/activate
    INSTALL_REQUIREMENT=true
    run ansible_run /tmp
    INSTALL_REQUIREMENT=false
    deactivate
    [[ $output == *'hello'* ]]
}

@test "Ansible run role on virtualenv." {
    $PY_EX -m venv /tmp/venv
    source /tmp/venv/bin/activate
    INSTALL_REQUIREMENT=true
    run ansible_run /tmp/role
    INSTALL_REQUIREMENT=false
    deactivate
    [[ "$output" == *'Ansible Role'* ]]
    [[ "$output" == *'one, two'* ]]
}

# Commented to adjust to travis free version 50 min limit.
# @test "Ansible gets installed via pip - sudoer." {

#     # Add testuser to sudoers.
#     /usr/sbin/addgroup testuser sudo
#     echo 'testuser  ALL=(ALL) NOPASSWD: ALL' | sudo EDITOR='tee -a' /usr/sbin/visudo

#     INSTALL_REQUIREMENT=true
#     uninstall_apt 'ansible'
#     uninstall_pip 'ansible'
#     INSTALL_REQUIREMENT=false

#     sudo -H -u testuser /bin/bash -c 'source /tmp/testme.sh && INSTALL_REQUIREMENT=true && ansible_setup'
#     run sudo -H -u testuser /bin/bash -c 'source /tmp/testme.sh && validate_pip "ansible"'
#     [[ "$output" == 'true' ]]
# }

# @test "Ansible gets installed via pip - non-sudoer." {

#     INSTALL_REQUIREMENT=true
#     uninstall_apt 'ansible'
#     uninstall_pip 'ansible'
#     INSTALL_REQUIREMENT=false

#     sudo -H -u testuser /bin/bash -c 'source /tmp/testme.sh && INSTALL_REQUIREMENT=true && ansible_setup'
#     run sudo -H -u testuser /bin/bash -c 'source /tmp/testme.sh && validate_pip "ansible"'
#     [[ "$output" == 'true' ]]
# }

# @test "Ansible sudo parameter." {

#     rm -f /tmp/test/test.py

#     # Add testuser to sudoers.
#     /usr/sbin/addgroup testuser sudo
#     echo 'testuser:1234' | /usr/sbin/chpasswd

#     # Convert become ansible task.
#     echo '    become: true' >> /tmp/test/test-playbook.yml

#     # Test passing become password.
#     run sudo -H -u testuser /bin/bash -c 'source /tmp/testme.sh && ansible_run /tmp "1234"'
#     [[ $output == *'hello'* ]]

# }

# @test "Ansible sudo parameter - virtualenv." {

#     rm -f /tmp/test/test.py

#     INSTALL_REQUIREMENT=true
#     uninstall_apt 'ansible'
#     uninstall_pip 'ansible'
#     INSTALL_REQUIREMENT=false

#     mkdir /tmp/venv
#     chmod a+rwx -R /tmp/venv

#     sudo -H -u testuser /bin/bash -c "$PY_EX -m venv /tmp/venv && source /tmp/venv/bin/activate && source /tmp/testme.sh && INSTALL_REQUIREMENT=true && ansible_setup && deactivate"
#     run sudo -H -u testuser /bin/bash -c 'source /tmp/venv/bin/activate && source /tmp/testme.sh && validate_pip "ansible" && deactivate'
#     [[ $output == 'true' ]]
#     run sudo -H -u testuser /bin/bash -c 'source /tmp/testme.sh && validate_pip "ansible"'
#     [[ $output == 'false' ]]

# }

# @test "Ansible don't exists - test folder don't exist." {
#     rm -rf /tmp/test
#     [[ $(ansible_exist /tmp) == 'false' ]]
# }

# @test "Ansible don't exists - test file don't exist." {
#     rm -f /tmp/test/test-playbook.yml
#     [[ $(ansible_exist /tmp) == 'false' ]]
# }

# @test "Ansible exists with .yml." {
#     [[ $(ansible_exist /tmp) == 'true' ]]
# }

# @test "Ansible exists with .yaml." {
#     mv /tmp/test/test-playbook.yml /tmp/test/test-playbook.yaml
#     [[ $(ansible_exist /tmp) == 'true' ]]
# }

# @test "Ansible don't exists library no files." {
#     rm -f /tmp/test/test-playbook.yml
#     mkdir /tmp/library
#     [[ $(ansible_exist /tmp) == 'false' ]]
# }

# @test "Ansible don't exists test_plugins no files." {
#     rm -f /tmp/test/test-playbook.yml
#     mkdir /tmp/test_plugins
#     [[ $(ansible_exist /tmp) == 'false' ]]
# }

# @test "Ansible exists library." {
#     rm -f /tmp/test/test-playbook.yml
#     mkdir /tmp/library
#     touch /tmp/library/none.py
#     [[ $(ansible_exist /tmp) == 'true' ]]
# }

# @test "Ansible exists test_plugins." {
#     rm -f /tmp/test/test-playbook.yml
#     mkdir /tmp/test_plugins
#     touch /tmp/test_plugins/none.py
#     [[ $(ansible_exist /tmp) == 'true' ]]
# }

# @test "Ansible python empty source path." {
#     run ansible_setup_python
#     [[ "$output" == *'source directory'* ]]
# }

# @test "Ansible python unexistent source path." {
#     run ansible_setup_python /dev/null
#     [[ "$output" == *'source directory'* ]]
# }

# @test "Ansible python empty destiny path." {
#     run ansible_setup_python /tmp
#     [[ "$output" == *'destiny directory'* ]]
# }

# @test "Ansible python unexistent destiny path." {
#     run ansible_setup_python /tmp /dev/null
#     [[ "$output" == *'destiny directory'* ]]
# }

# @test "Ansible python link library." {
#     mkdir /tmp/library
#     touch /tmp/library/none.py
#     run ansible_setup_python /tmp/library /tmp/test
#     [ -f /tmp/test/library/none.py ]
# }

# @test "Ansible python link test_plugins." {
#     mkdir /tmp/test_plugins
#     touch /tmp/test_plugins/none.py
#     ansible_setup_python /tmp/test_plugins /tmp/test
#     [ -f /tmp/test/test_plugins/none.py ]
# }

# @test "Ansible gets installed via pip." {
#     INSTALL_REQUIREMENT=true
#     uninstall_apt 'ansible'
#     uninstall_pip 'ansible'
#     run ansible_setup
#     INSTALL_REQUIREMENT=false
#     [[ $(validate_apt 'ansible') == 'false' ]]
#     [[ $(validate_pip 'ansible') == 'true' ]]
# }

# @test "Ansible copy role to user home." {
#     run ansible_setup /tmp/role
#     [ -d ~/.ansible/roles/constrict0r.role ]
# }

# @test "Ansible run role." {
#     rm -rf /tmp/role/library
#     rm -rf /tmp/role/test_plugins
#     rm -rf /tmp/role/test/test-playbook-module.yml
#     rm -rf /tmp/role/test/test-playbook-plugin.yml
#     rm -rf /tmp/role/test/conftest.py
#     rm -rf /tmp/role/test/test_module.py
#     rm -rf /tmp/role/test/test_plugin.py
#     run ansible_run /tmp/role
#     [[ "$output" == *'Ansible Role'* ]]
# }

# @test "Ansible run module." {
#     rm -rf /tmp/role/test_plugins
#     rm -rf /tmp/role/test/test-playbook-plugin.yml
#     rm -rf /tmp/role/test/test-playbook-role.yml
#     rm -rf /tmp/role/test/conftest.py
#     rm -rf /tmp/role/test/test_module.py
#     rm -rf /tmp/role/test/test_plugin.py
#     run ansible_run /tmp/role
#     [[ "$output" == *'one, two'* ]]
# }

# @test "Ansible test module." {
#      rm -rf /tmp/role/test/test-playbook-plugin.yml
#      rm -rf /tmp/role/test/test-playbook-role.yml
#      rm -rf /tmp/role/test/test_plugin.py
#      ansible_setup /tmp/role
#      run pytest_run /tmp/role
#      [[ "$output" == *'passed'* ]]
# }

# @test "Ansible run plugin." {
#     rm -rf /tmp/role/test/test_module.py
#     rm -rf /tmp/role/test/test-playbook-role.yml
#     rm -rf /tmp/role/test/test_plugin.yml
#     run ansible_run /tmp/role
#     [[ "$output" == *'777'* ]]
# }

# @test "Ansible test plugin". {
#     rm -rf /tmp/role/test/test_module.py
#     rm -rf /tmp/role/test/test-playbook-role.yml
#     rm -rf /tmp/role/test/test-playbook-plugin.yml
#     ansible_setup /tmp/role
#     run pytest_run /tmp/role
#     [[ "$output" == *'100%'* ]]
# }
