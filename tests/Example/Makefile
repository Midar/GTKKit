PROG_NOINST = Example
SRCS = MainWindow.m AppDelegate.m

include ../../buildsys.mk

CPPFLAGS += -I../../src
LIBS := -L../../src -lgtkkit ${LIBS}
LD = ${OBJC}
