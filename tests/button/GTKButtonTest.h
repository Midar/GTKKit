#import "GTKKit.h"

@interface GTKButtonTest: OFObject <OFApplicationDelegate, GTKWindowDelegate>

- (void)applicationDidFinishLaunching;

- (void)buttonClicked:(id)sender;

- (void)windowWillClose:(GTKWindow *)sender;

@end