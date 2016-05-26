#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKBin.h"
#import "typedefs.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKButton: GTKBin
@property (copy) GTKCallback onClick;
@property OF_NULLABLE_PROPERTY (assign) SEL action;
@property OF_NULLABLE_PROPERTY (unsafe_unretained) id target;
@end

OF_ASSUME_NONNULL_END
