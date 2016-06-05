#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKWidget.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKSeparator: GTKWidget

+ (id)separatorWithOrientation:(GtkOrientation)orientation;

- (id)initWithOrientation:(GtkOrientation)orientation;

@end

OF_ASSUME_NONNULL_END
