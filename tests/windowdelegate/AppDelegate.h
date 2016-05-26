#import "GTKKit.h"

@interface AppDelegate : OFObject <OFApplicationDelegate, GTKWindowDelegate>

- (void)applicationDidFinishLaunching;

- (void)applicationWillTerminate;

- (bool)windowShouldClose:(GTKWindow *)sender;

@end