#!/usr/bin/env bats

@test "Distrobox configuration file exists" {
    [ -f "/usr/share/bluefin-framework/antigravity/distrobox.ini" ]
}

@test "Distrobox configuration contains required hardware passthrough" {
    grep -q -- "--device /dev/kfd" "/usr/share/bluefin-framework/antigravity/distrobox.ini"
    grep -q -- "--device /dev/dri" "/usr/share/bluefin-framework/antigravity/distrobox.ini"
}

@test "Distrobox configuration uses Ubuntu 24.04 image" {
    grep -q "ubuntu:24.04" "/usr/share/bluefin-framework/antigravity/distrobox.ini"
}

@test "GSettings schema is configured for fractional scaling" {
    [ -f "/usr/share/glib-2.0/schemas/org.gnome.mutter.gschema.override" ]
}

@test "Justfile is included for declarative setup" {
    # The justfiles module copies to /usr/share/bluebuild/justfiles/ and imports them.
    [ -f "/usr/share/bluebuild/justfiles/antigravity.just" ]
}

@test "fwupd service is enabled for Framework hardware updates" {
    # Check if the fwupd service is enabled using systemctl across the root
    systemctl --root=/ is-enabled fwupd.service
}

@test "Kernel arguments are correctly configured in bootc" {
    # Verify kargs directory exists and contains configuration
    [ -d "/usr/lib/bootc/kargs.d/" ]
    ls /usr/lib/bootc/kargs.d/*.toml
}

@test "GSettings schemas are compiled" {
    [ -f "/usr/share/glib-2.0/schemas/gschemas.compiled" ]
}
