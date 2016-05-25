#import "GTKKit.h"

@interface Delegate : OFObject <GTKWindowDelegate>

- (void)windowDidMinimize:(GTKWindow*)sender;

- (void)windowDidUnminimize:(GTKWindow*)sender;

@end