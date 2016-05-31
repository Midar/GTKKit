PROG_NOINST = togglebutton
SRCS = GTKButtonTest.m

include ../../buildsys.mk

CPPFLAGS += -I../../src
OBJCFLAGS += -fobjc-arc -fobjc-arc-exceptions
LIBS := -L../../src -lgtkkit ${LIBS}
LD = ${OBJC}
