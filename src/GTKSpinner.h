#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKWidget.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKSpinner: GTKWidget
@property bool spinning;
- (void)start;
- (void)stop;
@end

OF_ASSUME_NONNULL_END
