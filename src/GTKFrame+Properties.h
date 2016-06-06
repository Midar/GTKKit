#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKFrame.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKFrame (Properties)
@property OFString *label;
@property GTKWidget *labelWidget;
@property float xAlign;
@property float yAlign;
@end

OF_ASSUME_NONNULL_END
