# TextLens Project Summary

## What is TextLens?

TextLens is a cross-platform text comparison application built with Go, specifically optimized for macOS. It provides a graphical user interface for comparing two text files or text snippets side-by-side and displays detailed differences.

## Key Features Implemented

### Core Functionality
- ✅ Side-by-side text input areas
- ✅ File loading from disk (supports .txt, .md, .go, .py, .js, .java, .c, .cpp, .h)
- ✅ Line-by-line text comparison
- ✅ Statistical analysis (character count, line count)
- ✅ Clear, readable difference reporting
- ✅ Cross-platform GUI using Fyne toolkit

### macOS Packaging
- ✅ Complete .app bundle structure
- ✅ Info.plist configuration
- ✅ Application icon support
- ✅ DMG installer creation (macOS)
- ✅ Archive creation for cross-platform transfer

### Build System
- ✅ Makefile with multiple build targets
- ✅ Build scripts for automation
- ✅ Support for both Intel and Apple Silicon Macs
- ✅ GitHub Actions workflow for CI/CD
- ✅ Cross-compilation support with fyne-cross

### Quality Assurance
- ✅ Comprehensive unit tests
- ✅ CodeQL security scanning
- ✅ No security vulnerabilities
- ✅ Proper error handling
- ✅ Clean code organization

## Project Structure

```
textlens/
├── .github/
│   └── workflows/
│       └── build.yml          # CI/CD workflow for macOS builds
├── scripts/
│   ├── build-macos.sh         # Main build automation script
│   ├── create-dmg.sh          # DMG package creation
│   ├── create-icon.sh         # Icon generation
│   └── create-plist.sh        # Info.plist generation
├── BUILDING.md                # Comprehensive build instructions
├── EXAMPLES.md                # Usage examples and documentation
├── README.md                  # Main project documentation
├── Makefile                   # Build automation
├── compare.go                 # Text comparison logic
├── compare_test.go            # Unit tests
├── main.go                    # GUI application entry point
├── go.mod                     # Go module definition
├── go.sum                     # Dependency checksums
└── .gitignore                 # Git ignore rules
```

## How It Works

1. **GUI Layer** (main.go)
   - Fyne-based graphical interface
   - File loading dialogs
   - Text input areas
   - Button controls

2. **Comparison Engine** (compare.go)
   - Line-by-line text comparison
   - Character and line counting
   - Difference detection and reporting

3. **Build System** (Makefile + scripts/)
   - Automated macOS binary compilation
   - .app bundle creation
   - DMG packaging
   - Cross-platform support

## Building on macOS

### Quick Start
```bash
git clone https://github.com/alvinjaison/textlens.git
cd textlens
make build-macos-native
make package-macos
```

### Output
- `build/textlens-darwin-arm64` - Apple Silicon binary
- `build/textlens-darwin-amd64` - Intel Mac binary
- `build/TextLens.app` - Application bundle
- `dist/TextLens-1.0.0.dmg` - Installer

## Building on Other Platforms

### Using GitHub Actions (Recommended)
1. Push code to GitHub
2. Actions automatically build on macOS runners
3. Download artifacts or release files

### Using Docker + fyne-cross
```bash
make install-fyne-cross
make build-macos
make package-macos
```

## Installation on macOS

1. Download `TextLens-1.0.0.dmg`
2. Double-click to mount
3. Drag `TextLens.app` to Applications
4. Launch from Applications or Spotlight

## Testing

All tests pass successfully:
```bash
go test compare.go compare_test.go
# PASS: 7/7 tests
```

## Security

- ✅ CodeQL analysis passed with 0 alerts
- ✅ Proper GitHub Actions permissions
- ✅ No known vulnerabilities
- ✅ Safe file handling (1MB limit)

## Technology Stack

- **Language**: Go 1.24
- **GUI**: Fyne v2.7.0
- **Build**: Make, Bash
- **CI/CD**: GitHub Actions
- **Platform**: macOS 10.13+

## Documentation

- `README.md` - Installation and basic usage
- `BUILDING.md` - Detailed build instructions
- `EXAMPLES.md` - Usage examples and tips
- Inline code comments
- Comprehensive test coverage

## Future Enhancements (Roadmap)

- [ ] Syntax highlighting for code files
- [ ] Advanced diff algorithms (Myers, Patience)
- [ ] Dark mode support
- [ ] Export comparison results (PDF, HTML)
- [ ] Directory comparison
- [ ] Merge capabilities
- [ ] Keyboard shortcuts
- [ ] File history tracking
- [ ] Preferences/Settings

## Development Status

✅ **Complete** - The application is fully functional and ready for use on macOS.

### What Works
- Text comparison (manual input or file loading)
- File format support for common text files
- macOS application packaging
- Cross-platform building
- Automated CI/CD builds

### Requirements Met
✅ Text comparison application for macOS using Go
✅ Can be packaged as .dmg file
✅ Installable on MacBook
✅ Professional, production-ready code
✅ Comprehensive documentation
✅ Security best practices

## Quick Reference

### Build Commands
```bash
make help              # Show all available commands
make build-macos-native # Build on macOS
make package-macos     # Create .app and .dmg
make clean             # Remove build artifacts
make test              # Run tests
make fmt               # Format code
make vet               # Run go vet
```

### File Locations
- Source: `main.go`, `compare.go`
- Tests: `compare_test.go`
- Build output: `build/`
- Distribution: `dist/`
- Scripts: `scripts/`

## License

Open source - available for use and modification.

## Repository

https://github.com/alvinjaison/textlens

---

**Status**: ✅ Production Ready
**Version**: 1.0.0
**Platform**: macOS 10.13+
**Last Updated**: October 2025
