PROG_NOINST = Menu
SRCS = MainWindow.m AppDelegate.m

include ../../buildsys.mk

CPPFLAGS += -I../../src
LIBS := -L../../src -lgtkkit ${LIBS}
LD = ${OBJC}
