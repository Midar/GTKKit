#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKRange.h"
#import "typedefs.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKScale: GTKRange

@property OF_NULLABLE_PROPERTY (assign) SEL action;
@property OF_NULLABLE_PROPERTY (weak) id target;

@end

OF_ASSUME_NONNULL_END
