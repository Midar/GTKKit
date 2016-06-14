include ../extra.mk

SHARED_LIB = ${GTKKIT_SHARED_LIB}
STATIC_LIB = ${GTKKIT_STATIC_LIB}
LIB_MAJOR = 0
LIB_MINOR = 0

SRCS  = GTKBin.m
SRCS += GTKButton+Properties.m
SRCS += GTKButton.m
SRCS += GTKComboBox.m
SRCS += GTKContainer.m
SRCS += GTKEntry.m
SRCS += GTKExpander.m
SRCS += GTKFrame.m
SRCS += GTKGrid+Actions.m
SRCS += GTKGrid.m
SRCS += GTKLabel+Properties.m
SRCS += GTKLabel.m
SRCS += GTKWidget+Actions.m
SRCS += GTKWidget+Properties.m
SRCS += GTKWidget.m
SRCS += GTKWindow+Actions.m
SRCS += GTKWindow+Properties.m
SRCS += GTKWindow.m
SRCS += GTKOverlay.m
SRCS += GTKImage.m
SRCS += GTKRange.m
SRCS += GTKScale.m
SRCS += GTKScale+Properties.m
SRCS += GTKProgressBar.m
SRCS += GTKSpinner.m
SRCS += GTKToggleButton.m
SRCS += GTKCheckButton.m
SRCS += GTKMenuItem.m
SRCS += GTKMenuItem+Properties.m
SRCS += GTKMenuShell.m
SRCS += GTKMenu.m
SRCS += GTKSeparator.m
SRCS += GTKSwitch.m
SRCS += GTKHeaderBar.m
SRCS += GTKHeaderBar+Actions.m
SRCS += GTKLevelBar.m
SRCS += GTKListBox.m
SRCS += GTKListBox+Actions.m
SRCS += GTKScrolledWindow.m
SRCS += GTKTextBuffer.m
SRCS += GTKTextView.m
SRCS += GTKPopover.m
SRCS += GTKDestroyedWidgetException.m
SRCS += GTKNoWrapperForGtkWidgetException.m
SRCS += GTKRowOutOfBoundsException.m
#SRCS += GTKScrollable.m

INCLUDES  = ${SRCS:.m=.h}
INCLUDES += GTKKit.h
INCLUDES += GTKWindowDelegate.h
INCLUDES += GTKOrientable.h

include ../buildsys.mk

LD = ${OBJC}
