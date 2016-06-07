#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKBin.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKScrolledWindow: GTKBin
@property GtkAdjustment *horizontalAdjustment;
@property GtkAdjustment *verticalAdjustment;
@property GtkPolicyType horizontalScrollingPolicy;
@property GtkPolicyType verticalScrollingPolicy;
@property GtkCornerType placement;
@property GtkShadowType shadowType;
@property int minContentWidth;
@property int minContentHeight;
@property bool kineticScrollingEnabled;
@property bool overlayScrollingEnabled;
@property bool captureButtonPress;
@end

OF_ASSUME_NONNULL_END
