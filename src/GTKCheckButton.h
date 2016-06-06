#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKToggleButton.h"
#import "typedefs.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKCheckButton: GTKToggleButton {
  gulong toggledHandlerID;
}
@end

OF_ASSUME_NONNULL_END
