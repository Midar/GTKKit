#import "GTKKit.h"

@interface AppDelegate : OFObject <OFApplicationDelegate, GTKWindowDelegate>

- (void)applicationDidFinishLaunching;

- (void)applicationWillTerminate;

- (void)windowWillClose:(GTKWindow *)sender;

@end