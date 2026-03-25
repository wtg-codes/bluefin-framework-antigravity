#!/usr/bin/env bats

# Note: These tests are designed to be run on the LIVE Framework hardware,
# not during the BlueBuild CI container build.

@test "Distrobox configuration file exists" {
    [ -f "/usr/share/bluefin-framework/antigravity/distrobox.ini" ]
}

@test "Distrobox configuration contains required hardware passthrough" {
    grep -q -- "--device /dev/kfd" "/usr/share/bluefin-framework/antigravity/distrobox.ini"
    grep -q -- "--device /dev/dri" "/usr/share/bluefin-framework/antigravity/distrobox.ini"
}

@test "Distrobox configuration includes Chrome installation hooks" {
    grep -q "google-chrome-stable" "/usr/share/bluefin-framework/antigravity/distrobox.ini"
}

@test "fwupd service is active (Framework hardware updates)" {
    # This must be run on the booted machine
    systemctl is-active fwupd.service || systemctl is-enabled fwupd.service
}

@test "Kernel arguments are actively applied to the system" {
    # Instead of checking the bootc toml files, we check the actual live kernel arguments
    run cat /proc/cmdline
    [[ "$output" == *"amd_pstate=active"* ]]
    [[ "$output" == *"amdgpu.sg_display=0"* ]]
}
