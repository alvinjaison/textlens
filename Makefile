.PHONY: all build build-macos build-macos-native build-linux clean package-macos help install-fyne-cross

# Application name
APP_NAME = TextLens
BINARY_NAME = textlens
VERSION ?= 1.0.0

# Build directory
BUILD_DIR = build
DIST_DIR = dist

# macOS specific
MACOS_APP = $(BUILD_DIR)/$(APP_NAME).app
MACOS_BINARY = $(MACOS_APP)/Contents/MacOS/$(BINARY_NAME)
DMG_NAME = $(APP_NAME)-$(VERSION).dmg

all: help

help:
	@echo "TextLens - Text Comparison Application"
	@echo ""
	@echo "Available targets:"
	@echo "  install-fyne-cross - Install fyne-cross tool for cross-compilation"
	@echo "  build-macos        - Build macOS binary using fyne-cross (Docker required)"
	@echo "  build-macos-native - Build macOS binary natively (macOS only)"
	@echo "  build-linux        - Build Linux binary (for testing)"
	@echo "  package-macos      - Create macOS .app bundle and .dmg file"
	@echo "  clean              - Remove build artifacts"
	@echo ""
	@echo "Variables:"
	@echo "  VERSION            - Application version (default: $(VERSION))"
	@echo ""
	@echo "Note: For macOS builds on non-macOS systems, you need Docker installed"
	@echo "      and the fyne-cross tool. Run 'make install-fyne-cross' first."

install-fyne-cross:
	@echo "Installing fyne-cross tool..."
	@go install github.com/fyne-io/fyne-cross@latest
	@echo "fyne-cross installed successfully"
	@echo ""
	@echo "Note: fyne-cross requires Docker to be installed and running"
	@echo "      Visit https://www.docker.com/get-started to install Docker"

build-macos:
	@echo "Building for macOS using fyne-cross..."
	@echo "This requires Docker to be installed and running"
	@mkdir -p $(BUILD_DIR)
	@if command -v fyne-cross >/dev/null 2>&1; then \
		fyne-cross darwin -arch=amd64,arm64 -app-id com.github.alvinjaison.textlens -output $(BINARY_NAME); \
		cp fyne-cross/dist/darwin-amd64/$(BINARY_NAME).app/Contents/MacOS/$(BINARY_NAME) $(BUILD_DIR)/$(BINARY_NAME)-darwin-amd64; \
		cp fyne-cross/dist/darwin-arm64/$(BINARY_NAME).app/Contents/MacOS/$(BINARY_NAME) $(BUILD_DIR)/$(BINARY_NAME)-darwin-arm64; \
		echo "macOS binaries created in $(BUILD_DIR)/"; \
	else \
		echo "Error: fyne-cross not found. Install it with: make install-fyne-cross"; \
		exit 1; \
	fi

build-macos-native:
	@echo "Building for macOS natively..."
	@echo "This only works on macOS systems"
	@mkdir -p $(BUILD_DIR)
	@go build -o $(BUILD_DIR)/$(BINARY_NAME)-darwin-$(shell uname -m) .
	@echo "macOS binary created in $(BUILD_DIR)/"

build-linux:
	@echo "Building for Linux..."
	@mkdir -p $(BUILD_DIR)
	go build -o $(BUILD_DIR)/$(BINARY_NAME) .
	@echo "Linux binary created: $(BUILD_DIR)/$(BINARY_NAME)"

package-macos:
	@echo "Creating macOS .app bundle..."
	@if [ ! -f "$(BUILD_DIR)/$(BINARY_NAME)-darwin-arm64" ] && [ ! -f "$(BUILD_DIR)/$(BINARY_NAME)-darwin-amd64" ]; then \
		echo "Error: No macOS binary found. Run 'make build-macos' or 'make build-macos-native' first."; \
		exit 1; \
	fi
	
	@mkdir -p $(MACOS_APP)/Contents/MacOS
	@mkdir -p $(MACOS_APP)/Contents/Resources
	
	# Copy binary (prefer arm64 for Apple Silicon, fallback to amd64 for Intel)
	@if [ -f "$(BUILD_DIR)/$(BINARY_NAME)-darwin-arm64" ]; then \
		cp $(BUILD_DIR)/$(BINARY_NAME)-darwin-arm64 $(MACOS_BINARY); \
	elif [ -f "$(BUILD_DIR)/$(BINARY_NAME)-darwin-amd64" ]; then \
		cp $(BUILD_DIR)/$(BINARY_NAME)-darwin-amd64 $(MACOS_BINARY); \
	fi
	@chmod +x $(MACOS_BINARY)
	
	# Create Info.plist
	@./scripts/create-plist.sh "$(MACOS_APP)/Contents/Info.plist" "$(VERSION)"
	
	# Create icon (placeholder - you can replace with actual icon later)
	@./scripts/create-icon.sh "$(MACOS_APP)/Contents/Resources/AppIcon.icns"
	
	@echo "Creating DMG package..."
	@mkdir -p $(DIST_DIR)
	@./scripts/create-dmg.sh "$(MACOS_APP)" "$(DIST_DIR)/$(DMG_NAME)"
	
	@echo ""
	@echo "✓ macOS package created!"
	@echo ""
	@echo "Install on macOS by:"
	@echo "  1. Transfer the package to your macOS machine"
	@if [ -f "$(DIST_DIR)/$(DMG_NAME)" ]; then \
		echo "  2. Double-click $(DMG_NAME)"; \
	else \
		echo "  2. Extract the .tar.gz file"; \
	fi
	@echo "  3. Drag $(APP_NAME).app to Applications folder"

clean:
	@echo "Cleaning build artifacts..."
	@rm -rf $(BUILD_DIR)
	@rm -rf $(DIST_DIR)
	@rm -rf fyne-cross
	@echo "Clean complete"

test:
	@echo "Running tests..."
	@go test -v ./...

fmt:
	@echo "Formatting code..."
	@go fmt ./...

vet:
	@echo "Running go vet..."
	@go vet ./...

