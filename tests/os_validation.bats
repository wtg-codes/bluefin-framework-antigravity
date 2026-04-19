#!/usr/bin/env bats

# wtgOS Validation Suite
# This suite verifies the integrity of the wtgOS image and its student workspace configuration.

@test "Distrobox configuration file exists at system path" {
    [ -f "files/usr/share/bluefin-framework/wtgOS/distrobox.ini" ]
}

@test "Distrobox configuration uses the declarative wtg-workspace image" {
    grep -q "image=ghcr.io/wtg-codes/wtg-workspace:latest" "files/usr/share/bluefin-framework/wtgOS/distrobox.ini"
}

@test "Distrobox configuration contains required hardware passthrough" {
    grep -q -- "--device /dev/kfd" "files/usr/share/bluefin-framework/wtgOS/distrobox.ini"
    grep -q -- "--device /dev/dri" "files/usr/share/bluefin-framework/wtgOS/distrobox.ini"
}

@test "Distrobox configuration enables Podman socket mounting" {
    grep -q "/run/user/1000/podman/podman.sock" "files/usr/share/bluefin-framework/wtgOS/distrobox.ini"
}

@test "Recipe contains mandatory Framework hardware kargs" {
    grep -q "amd_pstate=active" "recipes/recipe.yml"
    grep -q "amdgpu.sg_display=0" "recipes/recipe.yml"
}

@test "Recipe enables podman.socket for rootless orchestration" {
    grep -q "podman.socket" "recipes/recipe.yml"
}

@test "Recipe includes essential cloud-native Flatpaks" {
    grep -q "com.visualstudio.code" "recipes/recipe.yml"
    grep -q "com.google.Chrome" "recipes/recipe.yml"
    grep -q "de.haeckerfelix.Shortwave" "recipes/recipe.yml"
}

@test "Workspace Containerfile installs Antigravity IDE and apply wrappers" {
    grep -q "antigravity-ide" "files/workspace/Containerfile"
    grep -q "antigravity-ide.orig" "files/workspace/Containerfile"
}
