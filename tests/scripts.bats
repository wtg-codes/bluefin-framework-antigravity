#!/usr/bin/env bats

@test "example.sh executes successfully and outputs correct text" {
    run files/scripts/example.sh
    [ "$status" -eq 0 ]

    # Check if the output contains the expected strings
    echo "$output" | grep -q "This is an example shell script"
    echo "$output" | grep -q "Scripts here will run during build if specified in recipe.yml"
}
