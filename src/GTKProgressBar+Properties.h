#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKProgressBar.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKProgressBar (Properties)
@property double value;
@property bool inverted;
@property bool showText;
@property OFString *text;
@property bool ellipsize;
@property double pulseStep;
@end

OF_ASSUME_NONNULL_END
