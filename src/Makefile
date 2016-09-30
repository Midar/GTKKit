include ../extra.mk

SHARED_LIB = ${GTKKIT_SHARED_LIB}
STATIC_LIB = ${GTKKIT_STATIC_LIB}
LIB_MAJOR = 0
LIB_MINOR = 0

SRCS = GTKCallBackInfo.m		\
			 GTKResponder.m			\
			 GTKEvent.m			\
			 GTKLayoutConstraints.m			\
			 GTKView.m			\
			 GTKControl.m			\
			 GTKViewController.m			\
			 GTKApplicationDelegate.m

INCLUDES = ${SRCS:.m=.h}	\
	   GTKKit.h

include ../buildsys.mk

LD = ${OBJC}
