#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKToggleButton.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKCheckButton: GTKToggleButton
{
  gulong _toggledHandlerID;
}
@end

OF_ASSUME_NONNULL_END
