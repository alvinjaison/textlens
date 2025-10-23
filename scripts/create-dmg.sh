#!/bin/bash
# Script to create DMG package for macOS application

APP_PATH=$1
DMG_PATH=$2
APP_NAME=$(basename "$APP_PATH" .app)
TEMP_DMG=$(mktemp -u).dmg

echo "Creating DMG for $APP_NAME..."

# Check if we're on macOS (has hdiutil)
if command -v hdiutil &> /dev/null; then
    echo "Using hdiutil to create DMG (macOS native)"
    
    # Create temporary directory for DMG contents
    TEMP_DIR=$(mktemp -d)
    cp -R "$APP_PATH" "$TEMP_DIR/"
    
    # Create symlink to Applications
    ln -s /Applications "$TEMP_DIR/Applications"
    
    # Create DMG
    hdiutil create -volname "$APP_NAME" -srcfolder "$TEMP_DIR" -ov -format UDZO "$DMG_PATH"
    
    # Cleanup
    rm -rf "$TEMP_DIR"
    
else
    echo "hdiutil not available (not on macOS)"
    echo "Creating a simple archive instead..."
    
    # Create a tar.gz as alternative
    ARCHIVE_PATH="${DMG_PATH%.dmg}.tar.gz"
    tar -czf "$ARCHIVE_PATH" -C "$(dirname "$APP_PATH")" "$(basename "$APP_PATH")"
    
    echo ""
    echo "Created archive: $ARCHIVE_PATH"
    echo ""
    echo "Note: To create a proper .dmg file, you need to run this on macOS"
    echo "Alternative: Use create-dmg tool on macOS:"
    echo "  brew install create-dmg"
    echo "  create-dmg '$APP_NAME.app'"
    echo ""
    echo "For now, you can use the .tar.gz file to transfer and install on macOS:"
    echo "  1. Extract the archive"
    echo "  2. Move $APP_NAME.app to /Applications"
fi

echo "Done!"
