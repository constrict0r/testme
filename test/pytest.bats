#!/usr/bin/env bats
#
# From root folder run: ./testme.sh -d.

load shared

@test "Pytest run." {
    run pytest_run /tmp
    [[ "$output" == *'passed'* ]]
}

@test "Pytest python package (pyboom)." {
    rm -f /tmp/pyboom/tox.ini
    run pytest_run /tmp/pyboom
    [[ "$output" == *'passed'* ]]
}

# Commented to adjust to travis free version 50 min limit.
# @test "Pytest coverage." {
#     INSTALL_REQUIREMENT=true
#     ansible_setup /tmp/role
#     pytest_coverage /tmp/role
#     INSTALL_REQUIREMENT=false
#     [ -d /tmp/role/htmlcov ]
# }

# @test "Pytest don't exists - test folder don't exist." {
#     rm -rf /tmp/test
#     [[ $(pytest_exist /tmp) == 'false' ]]
# }

# @test "Pytest don't exists - test file don't exist." {
#     rm -f /tmp/test/test.py
#     [[ $(pytest_exist /tmp) == 'false' ]]
# }

# @test "Pytest exists." {
#     [[ $(pytest_exist /tmp) == 'true' ]]
# }

# @test "Pytest gets installed." {
#     INSTALL_REQUIREMENT=true
#     uninstall_pip 'pytest'
#     pytest_setup
#     INSTALL_REQUIREMENT=false
#     [[ $(validate_pip 'pytest') == 'true' ]]
# }