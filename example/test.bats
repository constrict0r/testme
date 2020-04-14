#!/usr/bin/env bats
#
# From root folder run: $script_name.sh.

setup() {
    # Set globals.
    CURRENT_PATH=${BATS_TEST_DIRNAME%/*}

    # Create test file.
    echo 'Hello' > /tmp/hello.txt
}

teardown() {
    # Execute cleanup.
    rm /tmp/hello.txt
}

@test "Validate I got a name." {
    ! [[ -z $(whoami) ]]

    run whoami
    [ $status -eq 0 ]

    run cat /tmp/hello.txt
    [[ "$output" == *'Hell'* ]]
}
