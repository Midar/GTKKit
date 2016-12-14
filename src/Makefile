include ../extra.mk

SHARED_LIB = ${GTKKIT_SHARED_LIB}
STATIC_LIB = ${GTKKIT_STATIC_LIB}
LIB_MAJOR = 0
LIB_MINOR = 0

SRCS =  GTKResponder.m                                                         \
	GTKDispatchQueue.m                                                     \
	GTKEvent.m                                                             \
	GTKLayoutConstraints.m                                                 \
	GTKView.m                                                              \
	GTKControl.m                                                           \
	GTKWindow.m                                                            \
	GTKTabbedWindow.m                                                      \
	GTKSplitView.m                                                         \
	GTKPopover.m                                                           \
	GTKApplication.m                                                       \
	GTKImage.m                                                             \
	GTKImageView.m                                                         \
	GTKButton.m                                                            \
	GTKSlider.m                                                            \
	GTKTextField.m                                                         \
	GTKLevelIndicator.m                                                    \
	GTKProgressIndicator.m                                                 \
	GTKPopUpButton.m                                                       \
	GTKBox.m                                                               \
	GTKSegmentedControl.m                                                  \
	GTKSeparator.m                                                         \
	GTKListView.m                                                          \
	GTKOffscreenRenderingWindow.m                                          \
	GTKInfoBar.m                                                           \
	GTKStatusbar.m                                                         \
	GTKActionBar.m                                                         \
	GTKComboBox.m                                                          \
	GTKCoder.m                                                             \
	GTKKeyedArchiver.m                                                     \
	GTKKeyedUnarchiver.m                                                   \
	GTKOutletConnection.m                                                  \
	GTKActionConnection.m                                                  \
	GTKLinearView.m                                                        \
	GTKTab.m                                                               \
	GTKTabView.m                                                           \
	GTKNotebookView.m                                                      \
	GTKMenu.m                                                              \
	GTKMenuItem.m                                                          \
	OFNull+GTKCoding.m                                                     \
	OFURL+GTKCoding.m                                                      \
	OFDate+GTKCoding.m                                                     \
	OFArray+GTKCoding.m                                                    \
	OFList+GTKCoding.m                                                     \
	OFString+GTKCoding.m                                                   \
	OFNumber+GTKCoding.m                                                   \
	OFDictionary+GTKCoding.m

INCLUDES =      ${SRCS:.m=.h}	                                               \
		GTKApplicationDelegate.h                                       \
		GTKWindowDelegate.h                                            \
		GTKListViewDataSource.h                                        \
		GTKListViewDelegate.h                                          \
		GTKPositionType.h                                              \
		GTKOrientable.h                                                \
		GTKCoding.h                                                    \
		GTKKit.h

include ../buildsys.mk

LD = ${OBJC}
