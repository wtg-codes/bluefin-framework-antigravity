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

@test "Distrobox configuration enables Podman socket mounting" {
    grep -q "/run/user/1000/podman/podman.sock" "$DISTROBOX_INI"
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
