NAME = dialog
CFLAGS = -O0 -g

.PHONY: all

all: ${NAME}.so ${NAME}.dll ${NAME}.dylib

dialog_res.c.inc: dialog_res.wren
	../../dome embed dialog_res.wren dialogModuleSource dialog_res.c.inc

${NAME}.dylib: ${NAME}.c dialog_res.c.inc
	gcc -dynamiclib -o dialog.dylib lib/tinyfiledialogs.c -I../../include dialog.c -undefined dynamic_lookup

${NAME}.so: ${NAME}.c dialog_res.c.inc
	gcc ${CFLAGS} -shared -std=c11 -o ${NAME}.so lib/tinyfiledialogs.c -fPIC -I../../include ${NAME}.c

${NAME}.dll: ${NAME}.c dialog_res.c.inc
	gcc ${CFLAGS} -shared -std=gnu11 -shared -fPIC  -I../../include ${NAME}.c -Wl,--unresolved-symbols=ignore-in-object-files -o ${NAME}.dll lib/tinyfiledialogs.c
.PHONY: clean

clean:
	rm -f dialog.so
	rm -f dialog.dll
	rm -f dialog.dylib
