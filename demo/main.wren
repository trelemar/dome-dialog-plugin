import "dome" for Process
import "graphics" for Canvas, Color
import "io" for FileSystem
import "plugin" for Plugin
import "input" for Mouse
 
Plugin.load("../dialog")

import "dialog" for Dialog

class Main {
	construct new() {}
	init() {
		_frame = 0
		_color = Color.hex("000000")
		_saveFile = Dialog.openFile("Open Save", FileSystem.basePath(), ["*.sav"], "")
		_str = FileSystem.load(_saveFile)
		_test = false
	}
	update() {
		if (Mouse.isButtonPressed("left")) {
			var clickFrame = _frame
			_str = Dialog.inputBox("INPUT BOX", "enter some text", FileSystem.load(_saveFile))
			var file = Dialog.saveFile("Save Game", FileSystem.basePath(), ["*.sav"], "")
			var color = Dialog.colorPicker("Pick a Background Color")
			if (color is String) color = Color.hex(color)
			var confirm = Dialog.messageBox("Confirm", "Really Change the Background color?", "yesno", "question")
			if (confirm = 1) _color = color

		}
	}
	draw(alpha) {
		_frame = _frame + 1
		Canvas.cls(_color)
		Canvas.print(_str, 0, 0, Color.white)
	}
}

var Game = Main.new()