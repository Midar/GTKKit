#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKContainer.h"
#import "GTKWindow.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKWindow (Properties)
@property (copy) OFString *title;
@property bool resizable;
@property bool modal;
@property of_point_t position;
@property (copy) GTKWindow *transientForWindow;
@property (copy) GTKWindow *attachedToWindow;
@property bool destroyWithParent;
@property (readonly) bool maximized;
@property bool decorated;
@property bool deletable;
@property (readonly) bool active;
@property bool hideTitlebarWhenMaximized;
@end

OF_ASSUME_NONNULL_END
