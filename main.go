package main

import (
	"fyne.io/fyne/v2"
	"fyne.io/fyne/v2/app"
	"fyne.io/fyne/v2/container"
	"fyne.io/fyne/v2/dialog"
	"fyne.io/fyne/v2/storage"
	"fyne.io/fyne/v2/widget"
)

func main() {
	myApp := app.New()
	myWindow := myApp.NewWindow("TextLens - Text Comparison")
	myWindow.Resize(fyne.NewSize(1000, 600))

	// Text areas for input
	leftText := widget.NewMultiLineEntry()
	leftText.SetPlaceHolder("Enter or load first text...")
	leftText.Wrapping = fyne.TextWrapWord

	rightText := widget.NewMultiLineEntry()
	rightText.SetPlaceHolder("Enter or load second text...")
	rightText.Wrapping = fyne.TextWrapWord

	// Result area
	resultText := widget.NewMultiLineEntry()
	resultText.SetPlaceHolder("Comparison results will appear here...")
	resultText.Wrapping = fyne.TextWrapWord

	// Load file buttons
	loadLeftBtn := widget.NewButton("Load File 1", func() {
		fd := dialog.NewFileOpen(func(reader fyne.URIReadCloser, err error) {
			if err != nil {
				dialog.ShowError(err, myWindow)
				return
			}
			if reader == nil {
				return
			}
			defer reader.Close()

			data := make([]byte, 1024*1024) // 1MB max
			n, err := reader.Read(data)
			if err != nil && err.Error() != "EOF" {
				dialog.ShowError(err, myWindow)
				return
			}
			leftText.SetText(string(data[:n]))
		}, myWindow)
		fd.SetFilter(storage.NewExtensionFileFilter([]string{".txt", ".md", ".go", ".py", ".js", ".java", ".c", ".cpp", ".h"}))
		fd.Show()
	})

	loadRightBtn := widget.NewButton("Load File 2", func() {
		fd := dialog.NewFileOpen(func(reader fyne.URIReadCloser, err error) {
			if err != nil {
				dialog.ShowError(err, myWindow)
				return
			}
			if reader == nil {
				return
			}
			defer reader.Close()

			data := make([]byte, 1024*1024) // 1MB max
			n, err := reader.Read(data)
			if err != nil && err.Error() != "EOF" {
				dialog.ShowError(err, myWindow)
				return
			}
			rightText.SetText(string(data[:n]))
		}, myWindow)
		fd.SetFilter(storage.NewExtensionFileFilter([]string{".txt", ".md", ".go", ".py", ".js", ".java", ".c", ".cpp", ".h"}))
		fd.Show()
	})

	// Compare button
	compareBtn := widget.NewButton("Compare Texts", func() {
		result := compareTexts(leftText.Text, rightText.Text)
		resultText.SetText(result)
	})

	// Clear button
	clearBtn := widget.NewButton("Clear All", func() {
		leftText.SetText("")
		rightText.SetText("")
		resultText.SetText("")
	})

	// Layout
	leftPanel := container.NewBorder(
		container.NewVBox(widget.NewLabel("Text 1"), loadLeftBtn),
		nil, nil, nil,
		container.NewScroll(leftText),
	)

	rightPanel := container.NewBorder(
		container.NewVBox(widget.NewLabel("Text 2"), loadRightBtn),
		nil, nil, nil,
		container.NewScroll(rightText),
	)

	resultPanel := container.NewBorder(
		widget.NewLabel("Comparison Results"),
		nil, nil, nil,
		container.NewScroll(resultText),
	)

	topContainer := container.NewHSplit(leftPanel, rightPanel)
	topContainer.Offset = 0.5

	mainContainer := container.NewVSplit(topContainer, resultPanel)
	mainContainer.Offset = 0.6

	buttonContainer := container.NewHBox(compareBtn, clearBtn)

	content := container.NewBorder(nil, buttonContainer, nil, nil, mainContainer)

	myWindow.SetContent(content)
	myWindow.ShowAndRun()
}
