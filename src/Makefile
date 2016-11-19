include ../extra.mk

SHARED_LIB = ${GTKKIT_SHARED_LIB}
STATIC_LIB = ${GTKKIT_STATIC_LIB}
LIB_MAJOR = 0
LIB_MINOR = 0

SRCS =	GTKResponder.m                              \
				GTKDispatchQueue.m                          \
				GTKEvent.m                                  \
				GTKLayoutConstraints.m                      \
				GTKView.m                                   \
				GTKControl.m                                \
				GTKViewController.m                         \
				GTKWindowViewController.m                   \
				GTKSplitViewController.m                    \
				GTKTabbedViewController.m                   \
				GTKTabbedWindowViewController.m             \
				GTKPopOverViewController.m                  \
				GTKApplication.m                            \
				GTKImage.m                                  \
				GTKImageView.m                              \
				GTKButton.m                                 \
				GTKSlider.m                                 \
				GTKTextField.m                              \
				GTKLevelIndicator.m                         \
				GTKProgressIndicator.m                      \
				GTKPopUpButton.m                            \
				GTKBox.m                                    \
				GTKSegmentedControl.m                       \
				GTKLinearViewController.m                   \
				GTKSeparator.m                              \
				GTKListViewController.m                     \
				GTKOffscreenRenderingViewController.m       \
				GTKInfoBar.m                                \
				GTKStatusbar.m                              \
				GTKActionBar.m                              \
				GTKComboBox.m                               \
				GTKCoder.m                                  \
				GTKKeyedArchiver.m                          \
				GTKKeyedUnarchiver.m                        \
				OFNull+GTKCoding.m                          \
				OFArray+GTKCoding.m                         \
				OFString+GTKCoding.m                        \
				OFNumber+GTKCoding.m                        \
				OFDictionary+GTKCoding.m

INCLUDES =                                          \
				${SRCS:.m=.h}	                              \
				GTKApplicationDelegate.h                    \
				GTKWindowViewControllerDelegate.h           \
				GTKListViewDataSource.h                     \
				GTKListViewDelegate.h                       \
				GTKPositionType.h                           \
				GTKCoding.h                                 \
				GTKKit.h

include ../buildsys.mk

LD = ${OBJC}
