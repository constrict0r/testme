#!/usr/bin/env bats
#
# From root folder run: ./testme.sh -d.

load shared

@test "Docker - Ansible - Debian recursive." {
    run /tmp/testme.sh -d -p /tmp -r -t a
    [ $status -eq 0 ]
}

@test "Docker - Ansible - Ubuntu recursive." {
    run /tmp/testme.sh -d -D ubuntu:bionic -p /tmp -r -t a
    [ $status -eq 0 ]
}

# Commented to adjust to travis free version 50 min limit.
# @test "Docker setup throws sudo error." {
#     INSTALL_REQUIREMENT=true
#     uninstall_apt 'containerd containerd.io docker docker-ce docker-engine docker.io runc'
#     INSTALL_REQUIREMENT=false
#     run sudo -u testuser bash -c 'source /tmp/testme.sh && INSTALL_REQUIREMENT=true && docker_setup'
#     [[ "$output" == *'docker needs to be installed'* ]]
# }

# @test "Docker - Bats - Debian recursive." {
#     run /tmp/testme.sh -d -p /tmp -r -t b
#     [ $status -eq 0 ]
# }

# @test "Docker - Bats - Ubuntu recursive." {
#     run /tmp/testme.sh -d -D ubuntu:bionic -p /tmp -r -t b
#     [ $status -eq 0 ]
# }

# @test "Docker - Ansible - Debian." {
#     run /tmp/testme.sh -d -p /tmp -t a
#     [ $status -eq 0 ]
# }

# @test "Docker - Ansible - Ubuntu" {
#     run /tmp/testme.sh -d -D ubuntu:bionic -p /tmp -t a
#     [ $status -eq 0 ]
# }

# @test "Docker - Bats - Debian." {
#     run /tmp/testme.sh -d -p /tmp -t b
#     [ $status -eq 0 ]
# }

# @test "Docker - Bats - Ubuntu" {
#     run /tmp/testme.sh -d -D ubuntu:bionic -p /tmp -t b
#     [ $status -eq 0 ]
# }
