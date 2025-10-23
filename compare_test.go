package main

import (
	"strings"
	"testing"
)

func TestCompareTextsIdentical(t *testing.T) {
	text1 := "Hello, World!"
	text2 := "Hello, World!"

	result := compareTexts(text1, text2)

	if !strings.Contains(result, "identical") {
		t.Errorf("Expected identical texts to be detected, got: %s", result)
	}
}

func TestCompareTextsDifferent(t *testing.T) {
	text1 := "Hello, World!"
	text2 := "Hello, Go!"

	result := compareTexts(text1, text2)

	if strings.Contains(result, "identical") {
		t.Errorf("Expected different texts to be detected as different")
	}

	if !strings.Contains(result, "differences") && !strings.Contains(result, "Differences") {
		t.Errorf("Expected result to mention differences, got: %s", result)
	}
}

func TestCompareTextsLineCount(t *testing.T) {
	text1 := "Line 1\nLine 2\nLine 3"
	text2 := "Line 1\nLine 2"

	result := compareTexts(text1, text2)

	if !strings.Contains(result, "3 lines") {
		t.Errorf("Expected text1 to have 3 lines mentioned in result")
	}

	if !strings.Contains(result, "2 lines") {
		t.Errorf("Expected text2 to have 2 lines mentioned in result")
	}
}

func TestCompareTextsCharacterCount(t *testing.T) {
	text1 := "Hello"
	text2 := "Hi"

	result := compareTexts(text1, text2)

	// Should mention character counts
	if !strings.Contains(result, "characters") {
		t.Errorf("Expected result to mention character count")
	}
}

func TestCompareTextsEmptyStrings(t *testing.T) {
	text1 := ""
	text2 := ""

	result := compareTexts(text1, text2)

	if !strings.Contains(result, "identical") {
		t.Errorf("Expected empty strings to be identical")
	}
}

func TestCompareTextsOneEmpty(t *testing.T) {
	text1 := "Some text"
	text2 := ""

	result := compareTexts(text1, text2)

	if strings.Contains(result, "identical") {
		t.Errorf("Expected non-empty and empty strings to be different")
	}
}

func TestCompareTextsMultilineDifferences(t *testing.T) {
	text1 := "Line 1\nLine 2\nLine 3"
	text2 := "Line 1\nDifferent Line 2\nLine 3"

	result := compareTexts(text1, text2)

	// Should detect the difference in line 2
	if !strings.Contains(result, "Line 2") {
		t.Errorf("Expected result to mention Line 2 where difference occurs")
	}
}
