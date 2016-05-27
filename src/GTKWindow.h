#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>

#import "GTKBin.h"
#import "GTKWindowDelegate.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKWindow: GTKBin
@property of_dimension_t defaultSize;
@property of_dimension_t size;
@property OF_NULLABLE_PROPERTY (unsafe_unretained)
    id <GTKWindowDelegate> delegate;
@end

OF_ASSUME_NONNULL_END
