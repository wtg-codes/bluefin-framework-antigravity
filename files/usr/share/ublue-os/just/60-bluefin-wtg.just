# Pull and assemble the agv-container developer environment
setup-workspace:
    @echo "Pulling and creating the agv-container workspace via Distrobox..."
    distrobox assemble create --file /usr/share/bluefin-wtg/distrobox.ini
    @echo "Done! Type 'distrobox enter agv-container' to begin."
