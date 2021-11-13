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
		_color = Color.hex("#FFFFFF")
	}
	update() {
		if (Mouse.isButtonPressed("left")) {
			var folder = Dialog.selectFolder("", ".")
			var str = Dialog.inputBox("INPUT BOX", "null", "DOME message")
			System.print(str)

			var file = Dialog.openFile("Open File", "untitled.txt", ["*.txt","*.png","*.wren"], "")
			file = Dialog.saveFile("", "", "", "")

			System.print(file)

			var ans = Dialog.messageBox("QUIT GAME", "Are you sure?", "yesno", "warning")
			System.print(ans)
			ans == 1 && Process.exit()
			_color = Color.hex(Dialog.colorPicker(""))
			if (_color is Color) return
		}
	}
	draw(alpha) {
		Canvas.cls(_color)
	}
}

var Game = Main.new()