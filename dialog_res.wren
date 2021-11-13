foreign class Dialog {
	construct init() {}
	foreign static messageBox(title, message, type, icon)
	foreign static inputBox(title, message, input)
	foreign static saveFile(title, defaultPath, filters, description)
	foreign static openFile(title, defaultPath, filters, description)
	foreign static selectFolder(title, defaultPath)
	foreign static colorPicker(title)
}