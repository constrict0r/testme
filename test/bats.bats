#!/usr/bin/env bats
#
# From root folder run: ./testme.sh -d.

load shared

@test "Bats run." {
    run bats_run /tmp
    [ $status -eq 0 ]
}

# Commented to adjust to travis free version 50 min limit.
# @test "Bats user can't install it (non-sudoer)." {
#     apt purge -y bats
#     run sudo -u testuser bash -c 'source /tmp/testme.sh && INSTALL_REQUIREMENT=true && bats_setup'
#     INSTALL_REQUIREMENT=true
#     bats_setup
#     INSTALL_REQUIREMENT=false
#     [[ "$output" == *'needs to be installed'* ]]
# }

# @test "Bats don't exists - test folder don't exist." {
#     rm -rf /tmp/test
#     [[ $(bats_exist /tmp) == 'false' ]]
# }

# @test "Bats don't exists - test file don't exist." {
#     rm -f /tmp/test/test.bats
#     [[ $(bats_exist /tmp) == 'false' ]]
# }

# @test "Bats exists." {
#     [[ $(bats_exist /tmp) == 'true' ]]
# }

# @test "Bats gets installed." {
#     apt purge -y bats
#     INSTALL_REQUIREMENT=true
#     bats_setup
#     INSTALL_REQUIREMENT=false
#     [[ $(validate_apt 'bats') == 'true' ]]
# }
