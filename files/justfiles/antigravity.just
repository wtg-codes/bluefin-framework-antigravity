# setup-antigravity: initializes the quarantined AI workspace
setup-antigravity:
    @echo "Setting up Antigravity (Ubuntu 24.04 FHS) with ROCm hardware passthrough..."
    @mkdir -p ~/.local/share/antigravity-workspace
    @distrobox assemble create --file /usr/share/bluefin-framework/antigravity/distrobox.ini
