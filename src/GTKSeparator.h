#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKWidget.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKSeparator: GTKWidget
+ (instancetype)separatorWithOrientation:(GtkOrientation)orientation;
- initWithOrientation:(GtkOrientation)orientation;
@end

OF_ASSUME_NONNULL_END
