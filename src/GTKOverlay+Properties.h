#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>

#import "GTKOverlay.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKOverlay (Properties)

- (bool)overlayChildPassthrough:(GTKWidget*)child;

- (void)setOverlayChildPassthrough:(GTKWidget*)child to:(bool)newValue;

@end

OF_ASSUME_NONNULL_END
