#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKRange.h"
#import "typedefs.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKScale: GTKRange {
  gulong valueChangedHandlerID;
  gulong formatHandlerID;
}
@property int digits;
@property OF_NULLABLE_PROPERTY (assign) SEL action;
@property OF_NULLABLE_PROPERTY (weak) id target;
@property OFString *formatString;
@property (nonatomic) OFString *formatStringBefore;
@property (nonatomic) OFString *formatStringAfter;
- (void)setFormatStringBefore:(OFString *)before
                        after:(OFString *)after;
@end

OF_ASSUME_NONNULL_END
