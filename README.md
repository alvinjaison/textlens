# TextLens

A text comparison application for macOS built with Go, featuring a modern GUI for comparing text files and displaying differences.

## Features

- 📝 Side-by-side text comparison
- 📂 Load and compare text files
- 🔍 Line-by-line difference detection
- 📊 Statistics on character and line counts
- 🎨 Clean, intuitive graphical user interface
- 🍎 Native macOS application (.app bundle)
- 📦 Easy installation via .dmg file

## Screenshots

The application provides a clean interface with two text input areas for comparison and a results panel showing detailed differences.

## Installation on macOS

### Option 1: Pre-built DMG (Recommended)

1. Download the latest `.dmg` file from the releases page
2. Double-click the `.dmg` file to mount it
3. Drag `TextLens.app` to your Applications folder
4. Launch TextLens from Applications or Spotlight

### Option 2: Build from Source

#### Prerequisites

- macOS 10.13 or later
- Go 1.19 or later
- Xcode Command Line Tools (for development)

#### Build Steps

1. Clone the repository:
```bash
git clone https://github.com/alvinjaison/textlens.git
cd textlens
```

2. Build the application:
```bash
make build-macos
```

3. Create the .app bundle and .dmg:
```bash
make package-macos
```

4. The `.dmg` file will be created in the `dist/` directory

5. Install the application:
   - Double-click `dist/TextLens-1.0.0.dmg`
   - Drag TextLens.app to Applications

## Usage

1. Launch TextLens from your Applications folder
2. Enter or load text in the two text areas:
   - Type directly into the text boxes, or
   - Click "Load File 1" / "Load File 2" to load text files
3. Click "Compare Texts" to see the differences
4. View the comparison results in the bottom panel
5. Use "Clear All" to reset and start a new comparison

### Supported File Formats

TextLens can load and compare various text-based files:
- `.txt` - Plain text files
- `.md` - Markdown files
- `.go` - Go source files
- `.py` - Python source files
- `.js` - JavaScript source files
- `.java` - Java source files
- `.c`, `.cpp`, `.h` - C/C++ source files

## Development

### Project Structure

```
textlens/
├── main.go              # Main application code
├── go.mod               # Go module dependencies
├── go.sum               # Dependency checksums
├── Makefile             # Build automation
├── scripts/             # Build and packaging scripts
│   ├── create-plist.sh  # Creates macOS Info.plist
│   ├── create-icon.sh   # Creates application icon
│   └── create-dmg.sh    # Creates DMG installer
└── README.md            # This file
```

### Building

```bash
# Build for macOS (creates binaries for both Intel and Apple Silicon)
make build-macos

# Build for Linux (for testing on Linux)
make build-linux

# Create complete macOS package (.app + .dmg)
make package-macos

# Clean build artifacts
make clean

# Run tests
make test

# Format code
make fmt

# Run go vet
make vet
```

### Cross-Platform Notes

TextLens uses the Fyne toolkit which supports cross-platform development. While this application is optimized for macOS, the core functionality can work on Linux and Windows as well.

To build for other platforms:
```bash
# Linux
GOOS=linux GOARCH=amd64 go build -o textlens-linux

# Windows
GOOS=windows GOARCH=amd64 go build -o textlens.exe
```

## Technology Stack

- **Language**: Go 1.24+
- **GUI Framework**: [Fyne](https://fyne.io/) v2.7.0
- **Build System**: Make
- **Packaging**: macOS .app bundle and .dmg

## Requirements

### Runtime (macOS)
- macOS 10.13 (High Sierra) or later
- No additional dependencies required

### Development
- Go 1.19 or later
- macOS (for creating .dmg files)
- Basic command-line tools (bash, make)

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Future Enhancements

Potential features for future versions:
- [ ] Syntax highlighting for code files
- [ ] Export comparison results
- [ ] Advanced diff algorithms (Myers, Patience)
- [ ] Dark mode support
- [ ] Keyboard shortcuts
- [ ] File history
- [ ] Directory comparison
- [ ] Merge functionality

## Troubleshooting

### Application won't open on macOS

If you see a security warning when opening TextLens:
1. Right-click (or Control-click) on TextLens.app
2. Select "Open" from the menu
3. Click "Open" in the security dialog

Or allow it in System Preferences:
1. Go to System Preferences → Security & Privacy
2. Click "Open Anyway" for TextLens

### Building fails

Make sure you have:
- Go installed and in your PATH (`go version`)
- All dependencies downloaded (`go mod tidy`)
- Sufficient disk space for build artifacts

## Contact

For issues, questions, or suggestions, please open an issue on GitHub.
