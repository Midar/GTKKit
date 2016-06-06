#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKWidget.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKWidget (Actions)
- (void)show;
- (void)showAll;
- (void)destroy;
- (void)hide;
- (bool)activate;
- (void)grabFocus;
- (void)grabDefault;
@end

OF_ASSUME_NONNULL_END
