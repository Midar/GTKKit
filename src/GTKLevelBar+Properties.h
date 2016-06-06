#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKLevelBar.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKLevelBar (Properties)
@property GtkLevelBarMode mode;
@property double value;
@property double minValue;
@property double maxValue;
@property bool inverted;
@end

OF_ASSUME_NONNULL_END
