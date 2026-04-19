#!/usr/bin/env bats

# wtgOS Validation Suite
# This suite verifies the integrity of the wtgOS image and its student workspace configuration.

@test "Distrobox configuration file exists" {
    # Check both system path (for CI/Live) and repository path (for local dev)
    [ -f "/usr/share/bluefin-framework/wtgOS/distrobox.ini" ] || [ -f "files/usr/share/bluefin-framework/wtgOS/distrobox.ini" ]
}

@test "Distrobox configuration uses the declarative wtg-workspace image" {
    FILE="/usr/share/bluefin-framework/wtgOS/distrobox.ini"
    [ ! -f "$FILE" ] && FILE="files/usr/share/bluefin-framework/wtgOS/distrobox.ini"
    grep -q "image=ghcr.io/wtg-codes/wtg-workspace:latest" "$FILE"
}

@test "Distrobox configuration contains required hardware passthrough" {
    FILE="/usr/share/bluefin-framework/wtgOS/distrobox.ini"
    [ ! -f "$FILE" ] && FILE="files/usr/share/bluefin-framework/wtgOS/distrobox.ini"
    grep -q -- "--device /dev/kfd" "$FILE"
    grep -q -- "--device /dev/dri" "$FILE"
}

@test "Distrobox configuration enables Podman socket mounting" {
    FILE="/usr/share/bluefin-framework/wtgOS/distrobox.ini"
    [ ! -f "$FILE" ] && FILE="files/usr/share/bluefin-framework/wtgOS/distrobox.ini"
    grep -q "/run/user/1000/podman/podman.sock" "$FILE"
}

@test "Kernel arguments are actively applied (simulated)" {
    # This checks the recipe which is copied into the image
    grep -q "amd_pstate=active" "/usr/etc/bluebuild/recipes/recipe.yml" || grep -q "amd_pstate=active" "recipes/recipe.yml"
}

@test "Workspace Containerfile logic check" {
    # Check if we correctly modified the source before building
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
