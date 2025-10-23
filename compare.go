package main

import (
	"fmt"
	"strings"
)

// compareTexts compares two text strings and returns a detailed comparison report
func compareTexts(text1, text2 string) string {
	if text1 == text2 {
		return "✓ Texts are identical!"
	}

	lines1 := strings.Split(text1, "\n")
	lines2 := strings.Split(text2, "\n")

	var result strings.Builder
	result.WriteString("Comparison Results:\n")
	result.WriteString("==================\n\n")

	// Basic statistics
	result.WriteString("Statistics:\n")
	result.WriteString(fmt.Sprintf("  Text 1: %d characters, %d lines\n", len(text1), len(lines1)))
	result.WriteString(fmt.Sprintf("  Text 2: %d characters, %d lines\n", len(text2), len(lines2)))
	result.WriteString("\n")

	// Line-by-line comparison
	result.WriteString("Line-by-Line Differences:\n")
	result.WriteString("-------------------------\n")

	maxLines := len(lines1)
	if len(lines2) > maxLines {
		maxLines = len(lines2)
	}

	differences := 0
	for i := 0; i < maxLines; i++ {
		line1 := ""
		line2 := ""

		if i < len(lines1) {
			line1 = lines1[i]
		}
		if i < len(lines2) {
			line2 = lines2[i]
		}

		if line1 != line2 {
			differences++
			result.WriteString(fmt.Sprintf("\nLine %d:\n", i+1))
			if i >= len(lines1) {
				result.WriteString(fmt.Sprintf("  Text 1: [MISSING]\n"))
			} else {
				result.WriteString(fmt.Sprintf("  Text 1: %s\n", line1))
			}
			if i >= len(lines2) {
				result.WriteString(fmt.Sprintf("  Text 2: [MISSING]\n"))
			} else {
				result.WriteString(fmt.Sprintf("  Text 2: %s\n", line2))
			}
		}
	}

	if differences == 0 {
		result.WriteString("\n✓ All lines are identical!")
	} else {
		result.WriteString(fmt.Sprintf("\n⚠ Found %d line(s) with differences", differences))
	}

	return result.String()
}
