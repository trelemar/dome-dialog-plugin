NAME = dialog
CFLAGS = -O0 -g

.PHONY: all

all: ${NAME}.so

dialog_res.c.inc: dialog_res.wren
	../../dome embed dialog_res.wren dialogModuleSource dialog_res.c.inc

${NAME}.so: ${NAME}.c dialog_res.c.inc
	gcc ${CFLAGS} -shared -std=c11 -o ${NAME}.so tinyfiledialogs.c -fPIC -I../../include ${NAME}.c

.PHONY: clean

clean:
	rm -f dialog.so
