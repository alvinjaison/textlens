# Usage Examples

This document provides examples of using TextLens for various text comparison tasks.

## Basic Text Comparison

1. Launch TextLens
2. Type or paste text into both text areas
3. Click "Compare Texts"
4. View differences in the results panel

## Comparing Code Files

TextLens is great for comparing source code:

```
Example: Comparing two versions of a function

Text 1:
func calculateSum(a, b int) int {
    return a + b
}

Text 2:
func calculateSum(a, b, c int) int {
    return a + b + c
}

Result:
Line 1:
  Text 1: func calculateSum(a, b int) int {
  Text 2: func calculateSum(a, b, c int) int {
Line 2:
  Text 1:     return a + b
  Text 2:     return a + b + c
```

## Comparing Configuration Files

Compare different versions of config files:

```
Example: .env files

Text 1:
DATABASE_URL=localhost:5432
API_KEY=abc123
DEBUG=false

Text 2:
DATABASE_URL=localhost:5432
API_KEY=xyz789
DEBUG=true
```

## Common Use Cases

### 1. Code Review
Load two versions of a file to review changes before committing.

### 2. Configuration Comparison
Compare development vs production configuration files.

### 3. Document Versions
Compare different versions of documentation or text documents.

### 4. Data Validation
Compare expected vs actual output from programs or tests.

### 5. Translation Review
Compare original text with translated versions.

## Keyboard Shortcuts

- **⌘+O**: Open file (when "Load File" button is focused)
- **⌘+Q**: Quit application
- **⌘+W**: Close window

## Tips

- **Large Files**: TextLens currently supports files up to 1MB. For larger files, consider splitting them or using command-line diff tools.
  
- **Line Endings**: The comparison is line-based, so different line endings (CRLF vs LF) will show as differences.

- **Whitespace**: Trailing whitespace and spacing differences are detected.

- **Case Sensitive**: All comparisons are case-sensitive.

## File Format Support

TextLens works best with plain text files:

- ✅ `.txt` - Plain text
- ✅ `.md` - Markdown
- ✅ `.go` - Go source
- ✅ `.py` - Python source  
- ✅ `.js` - JavaScript source
- ✅ `.java` - Java source
- ✅ `.c`, `.cpp`, `.h` - C/C++ source
- ✅ `.json` - JSON files
- ✅ `.xml` - XML files
- ✅ `.yaml`, `.yml` - YAML files

## Command Line Alternative

While TextLens provides a GUI, you can also use Go's testing framework for programmatic comparisons:

```go
package main

import (
    "testing"
    "github.com/alvinjaison/textlens"
)

func TestComparison(t *testing.T) {
    text1 := "Hello World"
    text2 := "Hello Go"
    
    result := compareTexts(text1, text2)
    // Use result for automated testing
}
```

## Advanced Features (Planned)

Future versions may include:
- Syntax highlighting for code
- Side-by-side visual diff
- Merge capabilities
- Directory comparison
- Export comparison results
- Custom comparison rules
