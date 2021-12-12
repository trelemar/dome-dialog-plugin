NAME = dialog
CFLAGS = -O0 -g
DOMEPATH ?= '~/git/dome'

.PHONY: all

all: ${NAME}.so ${NAME}.dll ${NAME}.dylib

dialog.c.inc: dialog.wren
	${DOMEPATH}/dome embed dialog.wren DIALOG_WREN_SOURCE dialog.c.inc

${NAME}.dylib: ${NAME}.c dialog.c.inc
	gcc -dynamiclib -o dialog.dylib lib/tinyfiledialogs.c -I../../include dialog.c -undefined dynamic_lookup

${NAME}.so: ${NAME}.c dialog.c.inc
	gcc ${CFLAGS} -shared -std=c11 -o ${NAME}.so lib/tinyfiledialogs.c -fPIC -I${DOMEPATH}/include ${NAME}.c

${NAME}.dll: ${NAME}.c dialog.c.inc
	x86_64-w64-mingw32-gcc-win32 ${CFLAGS} -shared -D _WIN32 -std=gnu11 -fPIC  -I../../include ${NAME}.c -Wl,--unresolved-symbols=ignore-in-object-files -o ${NAME}.dll lib/tinyfiledialogs.c -LC:/mingw/lib -lcomdlg32 -lole32

.PHONY: clean

clean:
	rm -f dialog.so
	rm -f dialog.dll
