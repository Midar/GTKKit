#import "GTKKit.h"

@interface AppDelegate : OFObject <OFApplicationDelegate, GTKWindowDelegate>

- (void)scaleValueChanged:(GTKScale *)sender;

@end