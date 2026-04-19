#!/usr/bin/env bats

# wtgOS Validation Suite
# This suite verifies the integrity of the wtgOS image and its student workspace configuration.

@test "Distrobox configuration file exists at system path" {
    [ -f "/usr/share/bluefin-framework/wtgOS/distrobox.ini" ]
}

@test "Distrobox configuration uses the declarative wtg-workspace image" {
    grep -q "image=ghcr.io/wtg-codes/wtg-workspace:latest" "/usr/share/bluefin-framework/wtgOS/distrobox.ini"
}

@test "Distrobox configuration contains required hardware passthrough" {
    grep -q -- "--device /dev/kfd" "/usr/share/bluefin-framework/wtgOS/distrobox.ini"
    grep -q -- "--device /dev/dri" "/usr/share/bluefin-framework/wtgOS/distrobox.ini"
}

@test "Distrobox configuration enables Podman socket mounting" {
    grep -q "/run/user/1000/podman/podman.sock" "/usr/share/bluefin-framework/wtgOS/distrobox.ini"
}

@test "Kernel arguments are actively applied (simulated)" {
    # This checks the recipe which is copied into the image
    grep -q "amd_pstate=active" "/usr/etc/bluebuild/recipes/recipe.yml" || grep -q "amd_pstate=active" "recipes/recipe.yml"
}

@test "Workspace Containerfile logic check" {
    # Check if we correctly modified the source before building
    [ -f "files/workspace/Containerfile" ] && grep -q "antigravity" "files/workspace/Containerfile"
}
