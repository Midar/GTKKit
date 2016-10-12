include ../extra.mk

SHARED_LIB = ${GTKKIT_SHARED_LIB}
STATIC_LIB = ${GTKKIT_STATIC_LIB}
LIB_MAJOR = 0
LIB_MINOR = 0

SRCS =	GTKCallback.m                               \
				GTKResponder.m                              \
				OFCallback.m                                \
				GTKEvent.m                                  \
				GTKLayoutConstraints.m                      \
				GTKView.m                                   \
				GTKControl.m                                \
				GTKViewController.m                         \
				GTKWindowViewController.m                   \
				GTKApplicationDelegate.m                    \
				OFApplication+GTKApplication.m              \
				OFApplication+GTKResponder.m                \
				GTKImage.m                                  \
				GTKImageView.m                              \
				GTKButton.m                                 \
				GTKInvalidLayoutConstraintsException.m

INCLUDES =                                          \
				${SRCS:.m=.h}	                              \
				GTKResponderProtocol.h                      \
				GTKKit.h

include ../buildsys.mk

LD = ${OBJC}
