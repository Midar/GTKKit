include ../extra.mk

SHARED_LIB = ${GTKKIT_SHARED_LIB}
STATIC_LIB = ${GTKKIT_STATIC_LIB}
LIB_MAJOR = 0
LIB_MINOR = 0

SRCS = GTKActionBar.m				\
       GTKBin.m					\
       GTKButton+Properties.m			\
       GTKButton.m				\
       GTKCheckButton.m				\
       GTKComboBox.m				\
       GTKContainer.m				\
       GTKDestroyedWidgetException.m		\
       GTKEntry.m				\
       GTKExpander.m				\
       GTKFrame.m				\
       GTKGrid+Actions.m			\
       GTKGrid.m				\
       GTKHeaderBar+Actions.m			\
       GTKHeaderBar.m				\
       GTKImage.m				\
       GTKLabel+Properties.m			\
       GTKLabel.m				\
       GTKLevelBar.m				\
       GTKListBox+Actions.m			\
       GTKListBox+Rows.m			\
       GTKListBox.m				\
       GTKMenu.m				\
       GTKMenuItem+Properties.m			\
       GTKMenuItem.m				\
       GTKMenuShell.m				\
       GTKNoWrapperForGtkWidgetException.m	\
       GTKOverlay.m				\
       GTKPopover.m				\
       GTKProgressBar.m				\
       GTKRadioButton.m				\
       GTKRange.m				\
       GTKRevealer.m				\
       GTKRowOutOfBoundsException.m		\
       GTKScale+Properties.m			\
       GTKScale.m				\
       GTKScrollable.m				\
       GTKScrolledWindow.m			\
       GTKSeparator.m				\
       GTKStack.m				\
       GTKStackSwitcher.m			\
       GTKSwitch.m				\
       GTKTextBuffer.m				\
       GTKTextView.m				\
       GTKToggleButton.m			\
       GTKWidget+Actions.m			\
       GTKWidget+Properties.m			\
       GTKWidget.m				\
       GTKWindow+Actions.m			\
       GTKWindow+Properties.m			\
       GTKWindow.m

INCLUDES = ${SRCS:.m=.h}	\
	   GTKKit.h		\
	   GTKWindowDelegate.h	\
	   GTKOrientable.h

include ../buildsys.mk

LD = ${OBJC}
