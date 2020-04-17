#!/usr/bin/env bats
#
# From root folder run: ./testme.sh -d.

load shared

@test "Ansible." {
    run /tmp/testme.sh -p /tmp -t a
    [ $status -eq 0 ]
}

@test "Poetry." {
    INSTALL_REQUIREMENT=true
    run /tmp/testme.sh -i -p /tmp/pyboom -t y
    INSTALL_REQUIREMENT=false
    [ $status -eq 0 ]
}

# Commented due to travis 50 min free limit.
# @test "Bats recursive." {
#     run /tmp/testme.sh -p /tmp -r -t b
#     [ $status -eq 0 ]
# }

# @test "Ansible pass sudo parameter." {
#     # Assing pass to testuser.
#     echo 'testuser:1234' | /usr/sbin/chpasswd
#     # Add testuser to sudoers.
#     /usr/sbin/addgroup testuser sudo
#     # Create sudo ansible task.
#     echo '    become: true' >> /tmp/test/test-playbook.yml
#     run sudo -u testuser /bin/bash -c "/tmp/testme.sh -p /tmp -t a -K '1234'"
#     [ $status -eq 0 ]
# }

# @test "Ansible recursive." {
#     run /tmp/testme.sh -p /tmp -r -t a
#     [ $status -eq 0 ]
# }

# @test "Bats." {
#     run /tmp/testme.sh -p /tmp -t b
#     [ $status -eq 0 ]
# }

# @test "Pytest coverage." {
#     INSTALL_REQUIREMENT=true
#     ansible_setup /tmp/role
#     INSTALL_REQUIREMENT=false
#     run /tmp/testme.sh -g -i -p /tmp/role -t p
#     [ -d /tmp/role/htmlcov ]
# }