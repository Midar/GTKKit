#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>

#import "GTKBin.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKOverlay: GTKBin (Properties)

- (bool)overlayChildPassthrough:(GTKWidget*)child;

@end

OF_ASSUME_NONNULL_END
