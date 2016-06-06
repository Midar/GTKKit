#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKToggleButton.h"
#import "typedefs.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKToggleButton (Properties)
@property bool drawIndicator;
@property bool active;
@property bool inconsistent;
@end

OF_ASSUME_NONNULL_END
