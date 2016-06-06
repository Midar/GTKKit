#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKBin.h"
#import "GTKWindowDelegate.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKWindow: GTKBin
{
  of_dimension_t _defaultSize;
  of_dimension_t _size;
}
@property of_dimension_t defaultSize;
@property of_dimension_t size;
@property OF_NULLABLE_PROPERTY (weak)
    id <GTKWindowDelegate> delegate;
@end

OF_ASSUME_NONNULL_END
