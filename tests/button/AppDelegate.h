#import "GTKKit.h"

@interface AppDelegate: OFObject <OFApplicationDelegate, GTKWindowDelegate>
@property GTKWindow *window;
@property GTKButton *button;
- (void)buttonClicked:(id)sender;
@end
