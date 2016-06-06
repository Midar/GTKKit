#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKContainer.h"
#import "GTKMenuItem.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKMenuShell: GTKContainer
- (void)appendMenuItem:(GTKMenuItem *)menuItem;
- (void)prependMenuItem:(GTKMenuItem *)menuItem;
- (void)insertMenuItem:(GTKMenuItem *)menuItem atPosition:(int)pos;
- (void)deactivate;
@end

OF_ASSUME_NONNULL_END
