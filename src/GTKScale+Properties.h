#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKScale.h"
#import "typedefs.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKScale (Properties)

@property int digits;
@property bool drawValue;

@end

OF_ASSUME_NONNULL_END
