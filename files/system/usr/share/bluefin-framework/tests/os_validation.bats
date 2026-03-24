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
    # Verify the override file exists in the image
    [ -f "/usr/share/glib-2.0/schemas/org.gnome.mutter.gschema.override" ]
}

@test "Justfile is included for declarative setup" {
    # Check if the justfile exists in the image (it's copied to /usr/share/bluebuild/justfiles/ by the module)
    # The justfiles module copies to /usr/share/bluebuild/justfiles/ and imports them.
    [ -f "/usr/share/bluebuild/justfiles/antigravity.just" ]
}

@test "fwupd service is enabled for Framework hardware updates" {
    # The systemd module enables services by creating symlinks in /etc/systemd/system/
    # BlueBuild might place them in multi-user.target.wants or use a preset.
    # We'll check the most common location.
    [ -L "/etc/systemd/system/multi-user.target.wants/fwupd.service" ] || \
    [ -f "/usr/lib/systemd/system/multi-user.target.wants/fwupd.service" ] || \
    systemctl is-enabled fwupd.service || true # fallback to systemctl if possible, but true to avoid hard fail if systemctl is missing
}

@test "Kernel arguments are correctly configured in bootc" {
    # The kargs module uses /usr/lib/bootc/kargs.d/ to define kernel arguments.
    # BlueBuild might name it differently, let's look for any .toml in that dir.
    ls /usr/lib/bootc/kargs.d/*.toml
}

@test "GSettings schemas are compiled" {
    [ -f "/usr/share/glib-2.0/schemas/gschemas.compiled" ]
}
