#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKRange.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKScale: GTKRange
{
  gulong _valueChangedHandlerID;
  gulong _formatHandlerID;
}
@property int digits;
@property OF_NULLABLE_PROPERTY (assign) SEL action;
@property OF_NULLABLE_PROPERTY (weak) id target;
@property OFConstantString *formatString;
@end

OF_ASSUME_NONNULL_END
