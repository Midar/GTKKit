include ../extra.mk

SHARED_LIB = ${GTKKIT_SHARED_LIB}
STATIC_LIB = ${GTKKIT_STATIC_LIB}
LIB_MAJOR = 0
LIB_MINOR = 0

SRCS = GTKBin.m                     \
       GTKButton+Properties.m       \
       GTKButton.m                  \
       GTKComboBox.m                \
       GTKContainer+Actions.m       \
       GTKContainer+Properties.m    \
       GTKContainer.m               \
       GTKEntry.m                   \
       GTKExpander+Properties.m     \
       GTKExpander.m                \
       GTKFrame+Properties.m        \
       GTKFrame.m                   \
       GTKGrid+Actions.m            \
       GTKGrid+Properties.m         \
       GTKGrid.m                    \
       GTKLabel+Properties.m        \
       GTKLabel.m                   \
       GTKWidget+Actions.m          \
       GTKWidget+Properties.m       \
       GTKWidget.m                  \
       GTKWindow+Actions.m          \
       GTKWindow+Properties.m       \
       GTKWindow.m                  \
       GTKOverlay.m                 \
       GTKOverlay+Actions.m         \
       GTKOverlay+Properties.m      \
       GTKImage.m                   \
       GTKRange.m                   \
       GTKScale.m                   \
       GTKScale+Properties.m        \
       GTKProgressBar.m             \
       GTKProgressBar+Properties.m  \
       GTKProgressBar+Actions.m     \
       GTKSpinner.m                 \
       GTKToggleButton.m            \
       GTKToggleButton+Properties.m \
       GTKCheckButton.m             \
       GTKMenuItem.m                \
       GTKMenuItem+Properties.m     \
       GTKMenuShell.m               \
       GTKMenu.m                    \
       GTKSeparator.m               \
       GTKSwitch.m                  \
       GTKHeaderBar.m               \
       GTKHeaderBar+Properties.m    \
       GTKHeaderBar+Actions.m       \
			 GTKLevelBar.m                \
			 GTKLevelBar+Properties.m     \
			 GTKListBox.m                 \
			 GTKListBox+Actions.m         \
			 GTKScrolledWindow.m          \
			 GTKDestroyedWidgetException.m

INCLUDES = ${SRCS:.m=.h}            \
           GTKKit.h                 \
           GTKWindowDelegate.h      \
           Orientable.h

include ../buildsys.mk

LD = ${OBJC}
