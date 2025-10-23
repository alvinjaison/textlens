# Building TextLens for macOS

This guide explains how to build TextLens for macOS distribution.

## Prerequisites

- **macOS 10.13+** (for native builds and DMG creation)
- **Go 1.19+**
- **Xcode Command Line Tools** (install with `xcode-select --install`)

## Quick Start (macOS)

If you're on macOS, building is straightforward:

```bash
# Clone the repository
git clone https://github.com/alvinjaison/textlens.git
cd textlens

# Install dependencies
go mod download

# Build the binary
make build-macos-native

# Create the .app bundle and .dmg
make package-macos
```

The `.dmg` file will be created in the `dist/` directory.

## Building on Non-macOS Systems

Building GUI applications with Go for macOS from other operating systems requires cross-compilation with CGO, which can be complex. We provide two approaches:

### Option 1: GitHub Actions (Recommended)

The repository includes a GitHub Actions workflow that builds on actual macOS runners:

1. Push your code to GitHub
2. GitHub Actions will automatically build macOS binaries
3. Download the artifacts from the Actions tab
4. For releases, create a tag: `git tag v1.0.0 && git push --tags`

### Option 2: Docker with fyne-cross

Install the fyne-cross tool:

```bash
make install-fyne-cross
```

Build using Docker (Docker must be running):

```bash
make build-macos
make package-macos
```

## Build Outputs

After building, you'll have:

- `build/textlens-darwin-arm64` - Binary for Apple Silicon Macs
- `build/textlens-darwin-amd64` - Binary for Intel Macs
- `build/TextLens.app` - macOS application bundle
- `dist/TextLens-1.0.0.dmg` - Installer DMG (macOS only)
- `dist/TextLens-1.0.0-macos.tar.gz` - Archive for transfer to macOS

## Manual Build Steps

If you prefer to build manually:

```bash
# Build the Go binary
go build -ldflags="-s -w" -o textlens .

# Create app bundle structure
mkdir -p TextLens.app/Contents/MacOS
mkdir -p TextLens.app/Contents/Resources

# Copy binary
cp textlens TextLens.app/Contents/MacOS/
chmod +x TextLens.app/Contents/MacOS/textlens

# Create Info.plist
./scripts/create-plist.sh TextLens.app/Contents/Info.plist 1.0.0

# Create icon (placeholder)
./scripts/create-icon.sh TextLens.app/Contents/Resources/AppIcon.icns

# Move to Applications
cp -R TextLens.app /Applications/
```

## Creating a Custom Icon

To replace the placeholder icon with a proper one:

1. Create a 1024x1024 PNG image
2. Use `iconutil` on macOS:

```bash
# Create iconset folder
mkdir TextLens.iconset

# Create required sizes
sips -z 16 16     icon.png --out TextLens.iconset/icon_16x16.png
sips -z 32 32     icon.png --out TextLens.iconset/icon_16x16@2x.png
sips -z 32 32     icon.png --out TextLens.iconset/icon_32x32.png
sips -z 64 64     icon.png --out TextLens.iconset/icon_32x32@2x.png
sips -z 128 128   icon.png --out TextLens.iconset/icon_128x128.png
sips -z 256 256   icon.png --out TextLens.iconset/icon_128x128@2x.png
sips -z 256 256   icon.png --out TextLens.iconset/icon_256x256.png
sips -z 512 512   icon.png --out TextLens.iconset/icon_256x256@2x.png
sips -z 512 512   icon.png --out TextLens.iconset/icon_512x512.png
sips -z 1024 1024 icon.png --out TextLens.iconset/icon_512x512@2x.png

# Create .icns
iconutil -c icns TextLens.iconset

# Copy to app
cp TextLens.icns build/TextLens.app/Contents/Resources/AppIcon.icns
```

## Troubleshooting

### "TextLens.app is damaged and can't be opened"

This happens because the app isn't code-signed. To allow it:

```bash
# Remove quarantine attribute
xattr -cr TextLens.app

# Or use Gatekeeper override
sudo spctl --master-disable
```

For distribution, you should code-sign the app:

```bash
codesign --force --deep --sign - TextLens.app
```

### Build fails on Linux

GUI builds don't work on Linux without X11 dependencies. Use the GitHub Actions workflow or build on macOS.

### DMG creation fails

DMG creation requires macOS. On other systems, a `.tar.gz` archive is created instead, which you can transfer to macOS and use the manual build steps.

## Development Build

For quick development testing on macOS:

```bash
go run .
```

This launches the app without creating a full bundle.

## Release Checklist

- [ ] Update version in Makefile
- [ ] Update README with new features
- [ ] Run tests: `go test ./...`
- [ ] Build for both architectures
- [ ] Test on Intel and Apple Silicon Macs
- [ ] Create proper app icon
- [ ] Code sign the application
- [ ] Create DMG with custom background
- [ ] Tag release: `git tag v1.x.x`
- [ ] Push tag to trigger GitHub Actions
- [ ] Verify release artifacts on GitHub

## Advanced: Code Signing for Distribution

For App Store or external distribution:

1. Enroll in Apple Developer Program
2. Create certificates in Xcode
3. Sign the app:

```bash
codesign --deep --force --verify --verbose \
  --sign "Developer ID Application: Your Name" \
  TextLens.app
```

4. Notarize with Apple:

```bash
xcrun notarytool submit TextLens-1.0.0.dmg \
  --apple-id your@email.com \
  --team-id TEAMID \
  --password "app-specific-password" \
  --wait
```

5. Staple the notarization:

```bash
xcrun stapler staple TextLens.app
```

## Resources

- [Fyne Documentation](https://docs.fyne.io/)
- [Go Cross Compilation](https://pkg.go.dev/cmd/go#hdr-Build_modes)
- [fyne-cross Tool](https://github.com/fyne-io/fyne-cross)
- [Apple Developer Documentation](https://developer.apple.com/documentation/)
