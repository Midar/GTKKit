PROG_NOINST = Coder
SRCS = AppDelegate.m CodedClass.m

include ../../buildsys.mk

CPPFLAGS += -I../../src
LIBS := -L../../src -lgtkkit ${LIBS}
LD = ${OBJC}
