#!/usr/bin/env bats

# wtgOS Validation Suite
# This suite verifies the integrity of the wtgOS image and its student workspace configuration.
# It is designed to be run both locally in the build tree and on the LIVE Framework hardware.

setup() {
    if [ -f "/usr/share/bluefin-framework/wtgOS/distrobox.ini" ]; then
        export DISTROBOX_INI="/usr/share/bluefin-framework/wtgOS/distrobox.ini"
        export IS_LIVE=1
    else
        export DISTROBOX_INI="files/usr/share/bluefin-framework/wtgOS/distrobox.ini"
        export IS_LIVE=0
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

@test "fwupd service is active (Framework hardware updates)" {
    [ "$IS_LIVE" -eq 1 ] || skip "Not on live system"
    systemctl is-active fwupd.service || systemctl is-enabled fwupd.service
}

@test "Kernel arguments are actively applied to the system" {
    [ "$IS_LIVE" -eq 1 ] || skip "Not on live system"
    run cat /proc/cmdline
    [[ "$output" == *"amd_pstate=active"* ]]
    [[ "$output" == *"amdgpu.sg_display=0"* ]]
}

@test "Kernel arguments are actively applied (simulated)" {
    if [ -f "recipes/recipe.yml" ]; then
        grep -q "amd_pstate=active" "recipes/recipe.yml"
    else
        grep -q "amd_pstate=active" "/usr/etc/bluebuild/recipes/recipe.yml"
    fi
}

@test "Workspace Containerfile logic check" {
    [ "$IS_LIVE" -eq 0 ] || skip "Not in build tree"
    [ -f "files/workspace/Containerfile" ] && grep -q "antigravity" "files/workspace/Containerfile"
}

@test "GitHub Actions workflows resolve Node 20 deprecation" {
    # Ensure no core actions are pinned to versions lower than Node 24 baseline
    # We check for @v followed by a single digit 0-4 for actions/checkout
    ! grep -r "actions/checkout@v[0-4]" .github/workflows/
    # Ensure FORCE_JAVASCRIPT_ACTIONS_TO_NODE24 is set
    grep -r "FORCE_JAVASCRIPT_ACTIONS_TO_NODE24: true" .github/workflows/
}

@test "Recipe contains default-flatpaks module configuration" {
    RECIPE="/usr/etc/bluebuild/recipes/recipe.yml"
    [ ! -f "$RECIPE" ] && RECIPE="recipes/recipe.yml"
    grep -q "type: default-flatpaks" "$RECIPE"
}

@test "Recipe flatpaks configuration contains expected communication apps" {
    RECIPE="/usr/etc/bluebuild/recipes/recipe.yml"
    [ ! -f "$RECIPE" ] && RECIPE="recipes/recipe.yml"
    grep -q "com.slack.Slack" "$RECIPE"
    grep -q "com.discordapp.Discord" "$RECIPE"
}

@test "Recipe flatpaks configuration includes developer tools" {
    RECIPE="/usr/etc/bluebuild/recipes/recipe.yml"
    [ ! -f "$RECIPE" ] && RECIPE="recipes/recipe.yml"
    grep -q "com.visualstudio.code" "$RECIPE"
    grep -q "com.google.Chrome" "$RECIPE"
}
