#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKHeaderBar.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKHeaderBar (Properties)
@property OFString *title;
@property OFString *subtitle;
@property bool hasSubtitle;
@property bool showCloseButton;
@property OFString *decorationLayout;
@end

OF_ASSUME_NONNULL_END
