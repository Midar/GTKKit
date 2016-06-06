#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKHeaderBar.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKHeaderBar (Actions)
- (void)addWidgetAtStart:(GTKWidget *)child;
- (void)addWidgetAtEnd:(GTKWidget *)child;
@end

OF_ASSUME_NONNULL_END
