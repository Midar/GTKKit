#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKWidget.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKSwitch: GTKWidget
@property bool active;
@property bool state;
@end

OF_ASSUME_NONNULL_END
