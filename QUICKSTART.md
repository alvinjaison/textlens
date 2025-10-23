# TextLens - Quick Start Guide

## Application Interface

When you launch TextLens, you'll see a clean, three-panel interface:

```
┌─────────────────────────────────────────────────────────────────────┐
│                    TextLens - Text Comparison                       │
├─────────────────────────────────┬───────────────────────────────────┤
│          Text 1                 │           Text 2                  │
│  ┌──────────────────────┐       │    ┌──────────────────────┐      │
│  │ [Load File 1]        │       │    │ [Load File 2]        │      │
│  └──────────────────────┘       │    └──────────────────────┘      │
│  ┌─────────────────────────┐    │    ┌─────────────────────────┐   │
│  │                         │    │    │                         │   │
│  │  Enter or load first    │    │    │  Enter or load second   │   │
│  │  text...                │    │    │  text...                │   │
│  │                         │    │    │                         │   │
│  │                         │    │    │                         │   │
│  │                         │    │    │                         │   │
│  └─────────────────────────┘    │    └─────────────────────────┘   │
├─────────────────────────────────┴───────────────────────────────────┤
│                      Comparison Results                             │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │ Comparison results will appear here...                      │   │
│  │                                                             │   │
│  └─────────────────────────────────────────────────────────────┘   │
├─────────────────────────────────────────────────────────────────────┤
│              [Compare Texts]        [Clear All]                     │
└─────────────────────────────────────────────────────────────────────┘
```

## Step-by-Step Usage

### Method 1: Manual Text Entry

1. **Launch the application**
   - Double-click TextLens.app from Applications
   - Or use Spotlight (⌘+Space, type "TextLens")

2. **Enter text**
   - Click in the left text area labeled "Text 1"
   - Type or paste your first text
   - Click in the right text area labeled "Text 2"
   - Type or paste your second text

3. **Compare**
   - Click the "Compare Texts" button
   - Results appear in the bottom panel

### Method 2: File Loading

1. **Load first file**
   - Click "Load File 1" button
   - Navigate to your file in the file picker
   - Select and open the file
   - The file contents appear in Text 1 area

2. **Load second file**
   - Click "Load File 2" button
   - Navigate to your second file
   - Select and open the file
   - The file contents appear in Text 2 area

3. **Compare**
   - Click "Compare Texts" button
   - Review the detailed comparison results

## Example Comparison

### Input
**Text 1:**
```
Hello, World!
This is line 2
This is line 3
```

**Text 2:**
```
Hello, World!
This is line two
This is line 3
Extra line here
```

### Output
```
Comparison Results:
==================

Statistics:
  Text 1: 45 characters, 3 lines
  Text 2: 61 characters, 4 lines

Line-by-Line Differences:
-------------------------

Line 2:
  Text 1: This is line 2
  Text 2: This is line two

Line 4:
  Text 1: [MISSING]
  Text 2: Extra line here

⚠ Found 2 line(s) with differences
```

## Keyboard Navigation

- **Tab**: Move between text areas
- **⌘+A**: Select all text in current area
- **⌘+C**: Copy selected text
- **⌘+V**: Paste text
- **⌘+X**: Cut selected text
- **⌘+Q**: Quit TextLens
- **⌘+W**: Close window

## Tips for Best Results

### For Code Comparison
- Use monospaced fonts (automatic in code mode)
- Compare files of the same type
- Check indentation differences

### For Document Comparison
- Use for plain text documents
- Works great with Markdown files
- Compare different versions of documentation

### Performance Tips
- Files are limited to 1MB for optimal performance
- For larger files, consider splitting them
- Clear results before new comparisons for better visibility

## Common Use Cases

### 1. Code Review
```bash
# Compare original and modified code
Load File 1: original.go
Load File 2: modified.go
Compare Texts
```

### 2. Configuration Comparison
```bash
# Compare dev vs prod configs
Load File 1: config.dev.txt
Load File 2: config.prod.txt
Compare Texts
```

### 3. Document Versioning
```bash
# Compare document versions
Load File 1: README_v1.md
Load File 2: README_v2.md
Compare Texts
```

### 4. Translation Check
```bash
# Compare original and translated text
Text 1: English version
Text 2: Translated version
Compare Texts
```

## Clearing the Workspace

To start a fresh comparison:
1. Click the "Clear All" button
2. All text areas will be cleared
3. Ready for new comparison

## Supported File Types

The file picker shows these extensions by default:
- `.txt` - Plain text files
- `.md` - Markdown files
- `.go` - Go source files
- `.py` - Python source files
- `.js` - JavaScript files
- `.java` - Java source files
- `.c`, `.cpp`, `.h` - C/C++ files

You can select "All Files" in the file picker to load any text file.

## Understanding Results

### Statistics Section
- **Characters**: Total number of characters (including spaces and newlines)
- **Lines**: Total number of lines in each text

### Differences Section
- **Line X**: The line number where difference was found
- **Text 1**: Shows the content from first text (or [MISSING] if line doesn't exist)
- **Text 2**: Shows the content from second text (or [MISSING] if line doesn't exist)

### Summary
- ✓ **Identical**: Both texts are exactly the same
- ⚠ **X differences**: Shows number of lines that differ between texts

## Troubleshooting

### Application won't open
- Right-click → Open (first time only)
- Or: System Preferences → Security & Privacy → Open Anyway

### File won't load
- Check file size (must be < 1MB)
- Ensure file is text-based (not binary)
- Check file permissions

### Comparison seems wrong
- Verify both texts are loaded correctly
- Check for hidden characters (tabs vs spaces)
- Look for line ending differences (CRLF vs LF)

## Getting Help

- Check README.md for installation help
- See BUILDING.md for build instructions
- Review EXAMPLES.md for more usage examples
- Open an issue on GitHub for bugs

---

**Enjoy using TextLens!**

For more information, visit: https://github.com/alvinjaison/textlens
