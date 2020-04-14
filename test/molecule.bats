#!/usr/bin/env bats
#
# From root folder run: ./testme.sh -d.

load shared

@test "Run molecule tests." {
    INSTALL_REQUIREMENT=true
    run molecule_run /tmp/role
    INSTALL_REQUIREMENT=true
    [ $status -eq 0 ]
}

# Commented to adjust to travis free version 50 min limit.
# @test "Molecule setup - docker gets installed." {
#     INSTALL_REQUIREMENT=true
#     uninstall_apt 'containerd containerd.io docker docker-ce docker-engine docker.io runc'
#     molecule_setup
#     INSTALL_REQUIREMENT=false
#     [[ $(validate_apt 'docker-ce') == 'true' ]]
# }

# @test "Molecule setup - molecule[docker] gets installed." {
#     INSTALL_REQUIREMENT=true
#     uninstall_apt 'containerd containerd.io docker docker-ce docker-engine docker.io runc'
#     molecule_setup
#     INSTALL_REQUIREMENT=false
#     [[ $(validate_pip 'molecule') == 'true' ]]
# }

# @test "Molecule do not exist - no molecule folder." {
#     [[ $(molecule_exist /tmp) == 'false' ]]
# }

# @test "Molecule exist." {
#     [[ $(molecule_exist /tmp/role) == 'true' ]]
# }
