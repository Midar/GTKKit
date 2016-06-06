#import "GTKKit.h"

@interface AppDelegate : OFObject <OFApplicationDelegate, GTKWindowDelegate>
@property GTKWindow *window;
@property GTKScale *scale;
- (void)scaleValueChanged:(GTKScale *)sender;
@end
