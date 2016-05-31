#import "GTKKit.h"

@interface GTKButtonTest: OFObject <OFApplicationDelegate, GTKWindowDelegate>

@property GTKWindow *window;
@property GTKToggleButton *button;

- (void)buttonToggled:(id)sender;

@end