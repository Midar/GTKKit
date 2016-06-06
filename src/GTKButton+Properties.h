#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKButton.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKButton (Properties)
@property OFString *label;
@property GtkReliefStyle reliefStyle;
@end

OF_ASSUME_NONNULL_END
