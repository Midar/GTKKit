#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKBin.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKMenuItem: GTKBin
{
  gulong _menuItemActivatedHandlerID;
}
@property OF_NULLABLE_PROPERTY (assign) SEL action;
@property OF_NULLABLE_PROPERTY (weak) id target;
@end

OF_ASSUME_NONNULL_END
