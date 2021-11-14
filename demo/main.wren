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
		_tests = [
			Dialog.messageBox("DOME Dialog Plugin","This is a test demo","ok","info"),
			Dialog.inputBox("Input box", "enter some text", " "),
			Dialog.saveFile("Save File As", ".", [], ""),
			Dialog.openFile("Open File", ".", [], ""),
			Dialog.selectFolder("Select Folder", "."),
			Dialog.colorPicker("Pick a color")
		]
		_tests.each {|test| System.print(test)}
		Dialog.messageBox("Test complete", "selections were traced to the console", "ok", "info")
		Process.exit()
	}
}

var Game = Main.new()