# DOME Dialog Plugin

See [this page](https://domeengine.com/modules/plugin) on info for including a plugin in your DOME project.

## `Dialog` class

### Methods

Most method arguments can be passed as an empty string (`""`) to use a default argument instead of your own.

#### `static messageBox(String: title, String: message, String: type, String; icon): Number`
- `title` can be any string.
- `message` can be any string.
- `type` can be `"ok" "okcancel" "yesno" "yesnocancel"`
- `icon` can be `"info" "warning" "error" "question"`

Returns 0 for cancel/no , 1 for ok/yes , 2 for no in yesnocancel

#### `static inputBox(String: title, String: message, String: input): String`
- `title` can be any string.
- `message` can be any string.
- `input` can be "" for a password box or any string.

Returns the string typed into the input box.

#### `static saveFile(String: title, String: defaultPath, List: filters, String: description): String`
- `title` can be any string.
- `defaultPath` can be a path to a specific file/folder or "".
- `filters` must be a List containing specific file types the user can save: `["*.jpg", "*.png"]` ect.
- The maximum amount of filters in the list is 10.
- `description` can be any string describing what kind of file the user is saving. `"image files"`

Returns the full path to file as a string.

#### `static openFile(String: title, String: defaultPath, List: filters, String: description): String`
- `title` can be any string.
- `defaultPath` can be a path to a specific file/folder or "".
- `filters` must be a List containing specific file types the user can open: `["*.jpg", "*.png"]` ect.
- The maximum amount of filters in the list is 10.
- `description` can be any string describing what kind of file the user is opening. `"image files"`

Returns the full path to file as a string.

#### `static selectFolder(String: title, String: path): String`
- `title` can be any string.
- `defaultPath` can be a path to a specific folder or "".

Returns the path selected as a string.

#### `static colorPicker(String: title): String`
- `title` can be any string.

Returns a hex code of the color selected as a string. Compatible with `Color.hex` api.