#import "GTKKit.h"

@interface GTKButtonTest: OFObject <OFApplicationDelegate, GTKWindowDelegate>

@property GTKWindow *window;
@property GTKCheckButton *button;

- (void)buttonToggled:(id)sender;

@end