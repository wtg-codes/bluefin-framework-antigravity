#!/usr/bin/env bats

# wtgOS Validation Suite
# This suite verifies the integrity of the wtgOS image and its student workspace configuration.
# It is designed to run both locally during development/CI and on the LIVE Framework hardware.

setup() {
    # Detect if we are running locally/in CI versus on the live system
    if [ -d "files/usr/share/bluefin-framework" ]; then
        export IS_LOCAL_CI=true
        export DISTROBOX_INI="files/usr/share/bluefin-framework/wtgOS/distrobox.ini"
        export RECIPE_FILE="recipes/recipe.yml"
    else
        export IS_LOCAL_CI=false
        export DISTROBOX_INI="/usr/share/bluefin-framework/wtgOS/distrobox.ini"
        export RECIPE_FILE="/usr/etc/bluebuild/recipes/recipe.yml"
    fi
}

@test "Distrobox configuration file exists" {
    [ -f "$DISTROBOX_INI" ]
}

@test "Distrobox configuration uses the declarative wtg-workspace image" {
    grep -q "image=ghcr.io/wtg-codes/wtg-workspace:latest" "$DISTROBOX_INI"
}

@test "Distrobox configuration contains required hardware passthrough" {
    grep -q -- "--device /dev/kfd" "$DISTROBOX_INI"
    grep -q -- "--device /dev/dri" "$DISTROBOX_INI"
}

@test "Distrobox configuration enables native Podman with init system" {
    grep -q "init=true" "$DISTROBOX_INI"
    ! grep -q "/run/user/1000/podman/podman.sock" "$DISTROBOX_INI"
}

@test "Kernel arguments are actively applied (simulated)" {
    grep -q "amd_pstate=active" "$RECIPE_FILE"
}

@test "Workspace Containerfile logic check" {
    # This test only makes sense in a local/CI context where the source repo is present
    if [ "$IS_LOCAL_CI" = "false" ]; then
        skip "Source files not available on live system"
    fi
    [ -f "files/workspace/Containerfile" ] && grep -q "antigravity" "files/workspace/Containerfile"
}

@test "GitHub Actions workflows resolve Node 20 deprecation" {
    # This test only makes sense in a local/CI context where the source repo is present
    if [ "$IS_LOCAL_CI" = "false" ]; then
        skip "Source files not available on live system"
    fi
    # Ensure no core actions are pinned to versions lower than Node 24 baseline
    # We check for @v followed by a single digit 0-4 for actions/checkout
    ! grep -r "actions/checkout@v[0-4]" .github/workflows/
    # Ensure FORCE_JAVASCRIPT_ACTIONS_TO_NODE24 is set
    grep -r "FORCE_JAVASCRIPT_ACTIONS_TO_NODE24: true" .github/workflows/
}

@test "Recipe contains default-flatpaks module configuration" {
    grep -q "type: default-flatpaks" "$RECIPE_FILE"
}

@test "Recipe flatpaks configuration contains expected communication apps" {
    grep -q "com.slack.Slack" "$RECIPE_FILE"
    grep -q "com.discordapp.Discord" "$RECIPE_FILE"
}

@test "Recipe flatpaks configuration includes developer tools" {
    grep -q "com.visualstudio.code" "$RECIPE_FILE"
    grep -q "com.google.Chrome" "$RECIPE_FILE"
}

@test "fwupd service is active (Framework hardware updates)" {
    if [ "$IS_LOCAL_CI" = "true" ]; then
        skip "fwupd check is only run on live system"
    fi
    # This must be run on the booted machine
    systemctl is-active fwupd.service || systemctl is-enabled fwupd.service
}

@test "Kernel arguments are actively applied to the system" {
    if [ "$IS_LOCAL_CI" = "true" ]; then
        skip "Live kernel arguments are only checked on live system"
    fi
    # Instead of checking the bootc toml files, we check the actual live kernel arguments
    run cat /proc/cmdline
    [[ "$output" == *"amd_pstate=active"* ]]
    [[ "$output" == *"amdgpu.sg_display=0"* ]]
}
