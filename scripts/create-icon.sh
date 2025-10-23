#!/bin/bash
# Script to create a placeholder icon for macOS application
# For production, replace this with actual icon generation using iconutil

ICON_FILE=$1

# Check if we have imagemagick installed
if command -v convert &> /dev/null; then
    # Create a simple icon using ImageMagick
    convert -size 512x512 xc:blue -font helvetica -pointsize 120 -fill white -gravity center -annotate +0+0 "TL" "$ICON_FILE" 2>/dev/null || {
        echo "Warning: Could not create icon with ImageMagick, creating placeholder"
        touch "$ICON_FILE"
    }
else
    echo "Note: ImageMagick not found, creating placeholder icon"
    echo "For a proper icon, install ImageMagick or create an .icns file manually"
    touch "$ICON_FILE"
fi

echo "Created icon placeholder at $ICON_FILE"
