CC ?= cc
AR ?= ar

ARFLAGS = rs
override LDFLAGS += -shared

INSTALL_SONAME_FLAG=soname
#INSTALL_SONAME_FLAG=install_name

PREFIX  = /usr/local

INC_DIR = $(PREFIX)/include
LIB_DIR = $(PREFIX)/lib

LIB_NAME=libexecinfo

STATIC_LIB_SUFFIX=.a
SHARED_LIB_SUFFIX=.so

STATIC_LIB_FILE_NAME=$(LIB_NAME)$(STATIC_LIB_SUFFIX)
SHARED_LIB_FILE_NAME=$(LIB_NAME)$(SHARED_LIB_SUFFIX)

OBJS = $(patsubst %.c, %.o, $(wildcard *.c))


build: $(STATIC_LIB_FILE_NAME) $(SHARED_LIB_FILE_NAME)

$(STATIC_LIB_FILE_NAME): $(OBJS)
	$(AR) $(ARFLAGS) $@ $^

$(SHARED_LIB_FILE_NAME): $(OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-$(INSTALL_SONAME_FLAG),$@ -o $@ $^

install: build
	install -d                     $(DEST_DIR)$(INC_DIR)
	install -m 644 execinfo.h      $(DEST_DIR)$(INC_DIR)
	install -m 644 stacktraverse.h $(DEST_DIR)$(INC_DIR)
	install -d                             $(DEST_DIR)$(LIB_DIR)
	install -m 644 $(STATIC_LIB_FILE_NAME) $(DEST_DIR)$(LIB_DIR)
	install -m 755 $(SHARED_LIB_FILE_NAME) $(DEST_DIR)$(LIB_DIR)

clean:
	rm -rf *.o *.a *.so *.dylib

distclean: clean

.PHONY: clean
