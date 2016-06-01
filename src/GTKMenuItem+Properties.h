#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKMenuItem.h"
#import "typedefs.h"
#import "GTKMenu.h"


@class GTKMenu;

OF_ASSUME_NONNULL_BEGIN

@interface GTKMenuItem (Properties)

@property OFString *label;
@property (weak) GTKMenu *submenu;

@end

OF_ASSUME_NONNULL_END
