#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKMenuItem.h"
#import "GTKMenu.h"

@class GTKMenu;

OF_ASSUME_NONNULL_BEGIN

@interface GTKMenuItem (Properties)
@property OFString *label;
@property GTKMenu *submenu;
- (id)initWithLabel:(OFString *)label;
+ (id)menuItemWithLabel:(OFString *)label;
@end

OF_ASSUME_NONNULL_END
