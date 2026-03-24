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

@test "GSettings schema is configured for fractional scaling" {
    # Verify the override file exists in the image
    [ -f "/usr/share/glib-2.0/schemas/org.gnome.mutter.gschema.override" ]
}

@test "Justfile is included for declarative setup" {
    # Check if the justfile exists in the image (it's copied to /usr/share/ublue-os/just/ by the module)
    # The justfiles module copies to /usr/share/bluebuild/justfiles/ and imports them.
    [ -f "/usr/share/bluebuild/justfiles/antigravity.just" ]
}

@test "fwupd service is enabled for Framework hardware updates" {
    # Check if the fwupd service is enabled in systemd
    [ -f "/usr/lib/systemd/system/multi-user.target.wants/fwupd.service" ] || \
    [ -f "/etc/systemd/system/multi-user.target.wants/fwupd.service" ]
}

@test "Kernel arguments are correctly configured in bootc" {
    # The kargs module uses /usr/lib/bootc/kargs.d/ to define kernel arguments.
    [ -f "/usr/lib/bootc/kargs.d/bluebuild-args.toml" ]
    grep -q "amd_pstate=active" "/usr/lib/bootc/kargs.d/bluebuild-args.toml"
    grep -q "amdgpu.sg_display=0" "/usr/lib/bootc/kargs.d/bluebuild-args.toml"
}

@test "GSettings schemas are compiled" {
    [ -f "/usr/share/glib-2.0/schemas/gschemas.compiled" ]
}
