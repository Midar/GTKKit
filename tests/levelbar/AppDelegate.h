#import "GTKKit.h"

@interface AppDelegate : OFObject <OFApplicationDelegate, GTKWindowDelegate>
@property GTKWindow *window;
@property GTKScale *scale;
@property GTKLevelBar *lbar;
@property GTKGrid *grid;
- (void)scaleValueChanged:(GTKScale *)sender;
@end
