#!/usr/bin/env bats

# wtgOS Validation Suite
# This suite verifies the integrity of the wtgOS image and its student workspace configuration.
# It is designed to run both locally in CI and on the live Framework hardware.

setup() {
    # Detect environment (Local/CI vs. Live)
    if [ -d "files/usr/share/bluefin-framework" ]; then
        export IS_LOCAL=true
        export DISTROBOX_INI="files/usr/share/bluefin-framework/wtgOS/distrobox.ini"
        export RECIPE_YML="recipes/recipe.yml"
    else
        export IS_LOCAL=false
        export DISTROBOX_INI="/usr/share/bluefin-framework/wtgOS/distrobox.ini"
        export RECIPE_YML="/usr/etc/bluebuild/recipes/recipe.yml"
    fi

    # Conditionally skip live-system-specific tests when running locally or in CI
    if [[ "$BATS_TEST_DESCRIPTION" == *"(Live)"* ]] && [ "$IS_LOCAL" = "true" ]; then
        skip "Skipping live system test in local/CI environment"
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
    grep -q "amd_pstate=active" "$RECIPE_YML"
}

@test "Workspace Containerfile logic check" {
    if [ -f "files/workspace/Containerfile" ]; then
        grep -q "antigravity" "files/workspace/Containerfile"
    fi
}

@test "GitHub Actions workflows resolve Node 20 deprecation" {
    if [ -d ".github/workflows" ]; then
        ! grep -r "actions/checkout@v[0-4]" .github/workflows/
        grep -r "FORCE_JAVASCRIPT_ACTIONS_TO_NODE24: true" .github/workflows/
    fi
}

@test "Recipe contains default-flatpaks module configuration" {
    grep -q "type: default-flatpaks" "$RECIPE_YML"
}

@test "Recipe flatpaks configuration contains expected communication apps" {
    grep -q "com.slack.Slack" "$RECIPE_YML"
    grep -q "com.discordapp.Discord" "$RECIPE_YML"
}

@test "Recipe flatpaks configuration includes developer tools" {
    grep -q "com.visualstudio.code" "$RECIPE_YML"
    grep -q "com.google.Chrome" "$RECIPE_YML"
}

@test "fwupd service is active (Framework hardware updates) (Live)" {
    systemctl is-active fwupd.service || systemctl is-enabled fwupd.service
}

@test "Kernel arguments are actively applied to the system (Live)" {
    run cat /proc/cmdline
    [[ "$output" == *"amd_pstate=active"* ]]
    [[ "$output" == *"amdgpu.sg_display=0"* ]]
}
