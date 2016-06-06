#import "GTKKit.h"

@interface AppDelegate: OFObject <OFApplicationDelegate, GTKWindowDelegate>
@property GTKWindow *window;
@property GTKToggleButton *button;
- (void)buttonToggled:(id)sender;
@end
