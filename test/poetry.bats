#!/usr/bin/env bats
#
# From root folder run: ./testme.sh -d.

load shared

@test "Poetry run." {
    INSTALL_REQUIREMENT=true
    run poetry_run /tmp/pyboom
    INSTALL_REQUIREMENT=false
    [[ "$output" == *'passed'* ]]
}

# # Commented to adjust to travis 50 min free limit.
# @test "Poetry tests don't exists." {
#     run poetry_exist /tmp
#     [[ $output == 'false' ]]
# }

# @test "Poetry tests exists." {
#     run poetry_exist /tmp/pyboom
#     [[ $output == 'true' ]]
# }

# @test "Poetry setup." {
#     INSTALL_REQUIREMENT=true
#     poetry_setup
#     INSTALL_REQUIREMENT=false
#     [[ $(validate_pip 'poetry') == 'true' ]]
# }