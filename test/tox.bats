#!/usr/bin/env bats
#
# From root folder run: ./testme.sh -d.

load shared

@test "Tox run." {
    INSTALL_REQUIREMENT=true
    run tox_run /tmp/pyboom
    INSTALL_REQUIREMENT=false
    [[ "$output" == *'succeeded'* ]]
}

# # Commented due to travis free 50 min limit.
# @test "Tox tests don't exists." {
#     run tox_exist /tmp
#     [[ $output == 'false' ]]
# }

# @test "Tox tests exists." {
#     run tox_exist /tmp/pyboom
#     [[ $output == 'true' ]]
# }

# @test "Tox setup." {
#     INSTALL_REQUIREMENT=true
#     tox_setup
#     INSTALL_REQUIREMENT=false
#     [[ $(validate_pip 'tox') == 'true' ]]
# }