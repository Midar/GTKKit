#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>

#import "GTKOverlay.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKOverlay (Actions)

- (void)addOverlayChild:(GTKWidget*)child;

- (void)reorderOverlayChild:(GTKWidget*)child toIndex:(int)index;

@end

OF_ASSUME_NONNULL_END
