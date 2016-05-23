#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKContainer.h"
#import "GTKWindow.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKWindow (Actions)
- (void)present;
- (bool)activateDefaultWidget;
- (bool)activateFocusedWidget;
- (void)close;
- (void)minimize;
- (void)unminimize;
- (void)maximize;
- (void)unmaximize;
- (void)fullscreen;
- (void)unfullscreen;
@end

OF_ASSUME_NONNULL_END
