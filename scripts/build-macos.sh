#!/bin/bash
# Simple build script for creating macOS application bundle without fyne-cross
# This creates a template .app bundle that can be built on macOS

set -e

APP_NAME="TextLens"
BINARY_NAME="textlens"
VERSION="${VERSION:-1.0.0}"
BUILD_DIR="build"
DIST_DIR="dist"

echo "=== TextLens Build Script for macOS ==="
echo ""

# Create directories
mkdir -p "$BUILD_DIR"
mkdir -p "$DIST_DIR"

# Detect platform
PLATFORM=$(uname -s)

if [ "$PLATFORM" = "Darwin" ]; then
    echo "✓ Running on macOS - building native binary"
    ARCH=$(uname -m)
    
    # Build native binary
    echo "Building for macOS ($ARCH)..."
    go build -ldflags="-s -w" -o "$BUILD_DIR/${BINARY_NAME}-darwin-${ARCH}" .
    
    echo "✓ Binary created: $BUILD_DIR/${BINARY_NAME}-darwin-${ARCH}"
    
else
    echo "⚠ Not running on macOS (detected: $PLATFORM)"
    echo ""
    echo "To build macOS binaries, you have several options:"
    echo ""
    echo "1. Build on a macOS machine:"
    echo "   git clone <repo>"
    echo "   cd textlens"
    echo "   make build-macos-native"
    echo "   make package-macos"
    echo ""
    echo "2. Use fyne-cross with Docker (cross-compilation):"
    echo "   make install-fyne-cross"
    echo "   make build-macos"
    echo "   make package-macos"
    echo ""
    echo "3. Use GitHub Actions / CI to build on macOS runners"
    echo ""
    echo "For now, creating a template .app bundle structure..."
    echo "You can build the actual binary on macOS and place it in the bundle."
fi

# Create .app bundle structure
APP_BUNDLE="$BUILD_DIR/${APP_NAME}.app"
echo ""
echo "Creating .app bundle structure at $APP_BUNDLE..."

mkdir -p "$APP_BUNDLE/Contents/MacOS"
mkdir -p "$APP_BUNDLE/Contents/Resources"

# Create Info.plist
echo "Creating Info.plist..."
./scripts/create-plist.sh "$APP_BUNDLE/Contents/Info.plist" "$VERSION"

# Create placeholder icon
echo "Creating icon..."
./scripts/create-icon.sh "$APP_BUNDLE/Contents/Resources/AppIcon.icns"

# If we have a binary, copy it
if [ -f "$BUILD_DIR/${BINARY_NAME}-darwin-arm64" ]; then
    echo "Copying arm64 binary..."
    cp "$BUILD_DIR/${BINARY_NAME}-darwin-arm64" "$APP_BUNDLE/Contents/MacOS/$BINARY_NAME"
    chmod +x "$APP_BUNDLE/Contents/MacOS/$BINARY_NAME"
elif [ -f "$BUILD_DIR/${BINARY_NAME}-darwin-amd64" ]; then
    echo "Copying amd64 binary..."
    cp "$BUILD_DIR/${BINARY_NAME}-darwin-amd64" "$APP_BUNDLE/Contents/MacOS/$BINARY_NAME"
    chmod +x "$APP_BUNDLE/Contents/MacOS/$BINARY_NAME"
elif [ "$PLATFORM" = "Darwin" ]; then
    # We just built it above
    ARCH=$(uname -m)
    if [ -f "$BUILD_DIR/${BINARY_NAME}-darwin-${ARCH}" ]; then
        echo "Copying native binary..."
        cp "$BUILD_DIR/${BINARY_NAME}-darwin-${ARCH}" "$APP_BUNDLE/Contents/MacOS/$BINARY_NAME"
        chmod +x "$APP_BUNDLE/Contents/MacOS/$BINARY_NAME"
    fi
else
    echo "⚠ No binary found - you'll need to build on macOS and add it to:"
    echo "   $APP_BUNDLE/Contents/MacOS/$BINARY_NAME"
fi

echo ""
echo "✓ .app bundle created at: $APP_BUNDLE"

# Try to create DMG if on macOS
if [ "$PLATFORM" = "Darwin" ] && [ -f "$APP_BUNDLE/Contents/MacOS/$BINARY_NAME" ]; then
    echo ""
    echo "Creating DMG package..."
    ./scripts/create-dmg.sh "$APP_BUNDLE" "$DIST_DIR/${APP_NAME}-${VERSION}.dmg"
    
    echo ""
    echo "=== Build Complete ==="
    echo "✓ Application bundle: $APP_BUNDLE"
    echo "✓ DMG installer: $DIST_DIR/${APP_NAME}-${VERSION}.dmg"
    echo ""
    echo "To install:"
    echo "  1. Double-click the .dmg file"
    echo "  2. Drag TextLens.app to Applications"
else
    # Create tar.gz for transfer to macOS
    echo ""
    echo "Creating archive for transfer to macOS..."
    ARCHIVE="$DIST_DIR/${APP_NAME}-${VERSION}-macos.tar.gz"
    tar -czf "$ARCHIVE" -C "$BUILD_DIR" "${APP_NAME}.app"
    
    echo ""
    echo "=== Build Complete ==="
    echo "✓ Application bundle: $APP_BUNDLE"
    echo "✓ Archive: $ARCHIVE"
    echo ""
    echo "Next steps:"
    echo "  1. Transfer $ARCHIVE to a macOS machine"
    echo "  2. Extract: tar -xzf $(basename $ARCHIVE)"
    echo "  3. Build the binary on macOS: go build -o TextLens.app/Contents/MacOS/textlens ."
    echo "  4. Move TextLens.app to /Applications"
    echo ""
    echo "Or use fyne-cross with Docker for full cross-compilation"
fi
