NAME = dialog
CFLAGS = -O0 -g

.PHONY: all

all: ${NAME}.so ${NAME}.dll ${NAME}.dylib

dialog.c.inc: dialog.wren
	../../dome embed dialog.wren DIALOG_WREN_SOURCE dialog.c.inc

${NAME}.dylib: ${NAME}.c dialog.c.inc
	gcc -dynamiclib -o dialog.dylib lib/tinyfiledialogs.c -I../../include dialog.c -undefined dynamic_lookup

${NAME}.so: ${NAME}.c dialog.c.inc
	gcc ${CFLAGS} -shared -std=c11 -o ${NAME}.so lib/tinyfiledialogs.c -fPIC -I../../include ${NAME}.c

${NAME}.dll: ${NAME}.c dialog.c.inc
	#gcc ${CFLAGS} -D _WIN32 -shared -std=gnu11 -shared -fPIC  -I../../include ${NAME}.c -Wl,--unresolved-symbols=ignore-in-object-files -o ${NAME}.dll lib/tinyfiledialogs.c -LC:/mingw/lib -lcomdlg32 -lole32
	#gcc ${CFLAGS} -D _WIN32 -shared -std=gnu11 -shared -fPIC -I../../include -I'C:\cygwin\usr\i686-pc-mingw32\sys-root\mingw\include' ${NAME}.c -Wl,--unresolved-symbols=ignore-in-object-files -o ${NAME}.dll lib/tinyfiledialogs.c -LC:/mingw/lib -lcomdlg32 -lole32
	x86_64-w64-mingw32-gcc-win32 ${CFLAGS} -D _WIN32 -shared -std=gnu11 -shared -fPIC  -I../../include ${NAME}.c -Wl,--unresolved-symbols=ignore-in-object-files -o ${NAME}.dll lib/tinyfiledialogs.c -LC:/mingw/lib -lcomdlg32 -lole32

.PHONY: clean

clean:
	rm -f dialog.so
	rm -f dialog.dll
