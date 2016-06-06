#import "GTKKit.h"

@interface AppDelegate: OFObject <OFApplicationDelegate, GTKWindowDelegate>
@property GTKWindow *window;
@property GTKCheckButton *button;
- (void)buttonToggled:(id)sender;
@end
