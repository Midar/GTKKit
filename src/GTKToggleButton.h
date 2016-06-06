#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKButton.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKToggleButton: GTKButton
{
  gulong _buttonToggledHandlerID;
}
@end

OF_ASSUME_NONNULL_END
