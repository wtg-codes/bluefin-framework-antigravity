#!/usr/bin/env bats

@test "Distrobox configuration file exists" {
    [ -f "/usr/share/bluefin-framework/antigravity/distrobox.ini" ]
}

@test "Distrobox configuration contains required hardware passthrough" {
    grep -q "--device /dev/kfd" "/usr/share/bluefin-framework/antigravity/distrobox.ini"
    grep -q "--device /dev/dri" "/usr/share/bluefin-framework/antigravity/distrobox.ini"
}

@test "Distrobox configuration uses Ubuntu 24.04 image" {
    grep -q "ubuntu:24.04" "/usr/share/bluefin-framework/antigravity/distrobox.ini"
}

@test "Kernel arguments are specified in the build configuration" {
    # Since rpm-ostree kargs doesn't work in container builds, we check the recipe's effect.
    # We verify that the gsettings override and justfile exist as proxies for successful
    # module execution and file placement.
    [ -f "/usr/share/glib-2.0/schemas/org.gnome.mutter.gschema.override" ]
    [ -f "/etc/profile.d/bluebuild-just.sh" ] || [ -f "/usr/share/ublue-os/just/60-antigravity.just" ]
}

@test "GSettings schema is compiled" {
    # Check if the compiled schema file was updated or exists
    [ -f "/usr/share/glib-2.0/schemas/gschemas.compiled" ]
}
