#import "GTKExpander.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKExpander (Properties)
@property OFString *label;
@property bool expanded;
@property int spacing;
@property bool resizeToplevel;
+ (instancetype)expanderWithLabel: (OFString*)label;
- initWithLabel:(OFString *)label;
@end

OF_ASSUME_NONNULL_END
