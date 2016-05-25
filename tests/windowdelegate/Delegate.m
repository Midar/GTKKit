#import "GTKKit.h"
#import "Delegate.h"

@implementation Delegate : OFObject

- (void)windowDidMinimize:(GTKWindow*)sender {
  printf("Window was minimized.\n");
}

- (void)windowDidUnminimize:(GTKWindow*)sender {
  printf("Window was unminimized.\n");
}

@end