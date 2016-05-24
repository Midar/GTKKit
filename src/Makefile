include ../extra.mk

SHARED_LIB = ${GTKKIT_SHARED_LIB}
STATIC_LIB = ${GTKKIT_STATIC_LIB}
LIB_MAJOR = 0
LIB_MINOR = 0

SRCS = GTKBin.m				\
       GTKButton+Properties.m		\
       GTKButton.m			\
       GTKComboBox.m			\
       GTKContainer+Actions.m		\
       GTKContainer+Properties.m	\
       GTKContainer.m			\
       GTKEntry.m			\
       GTKExpander+Properties.m		\
       GTKExpander.m			\
       GTKFrame+Properties.m		\
       GTKFrame.m			\
       GTKGrid+Actions.m		\
       GTKGrid+Properties.m		\
       GTKGrid.m			\
       GTKLabel+Properties.m		\
       GTKLabel.m			\
       GTKWidget+Actions.m		\
       GTKWidget+Callbacks.m		\
       GTKWidget+Properties.m		\
       GTKWidget.m			\
       GTKWindow+Actions.m		\
       GTKWindow+Properties.m		\
       GTKWindow.m        \
       GTKOverlay.m        \
       GTKOverlay+Actions.m       \
       GTKOverlay+Properties.m


INCLUDES := ${SRCS:.m=.h}

include ../buildsys.mk

OBJCFLAGS += -fobjc-arc -fobjc-arc-exceptions
LD = ${OBJC}
