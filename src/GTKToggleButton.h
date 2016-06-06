#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKButton.h"
#import "typedefs.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKToggleButton: GTKButton {
  gulong buttonToggledHandlerID;
}
@end

OF_ASSUME_NONNULL_END
