#import "GTKKit.h"

@interface AppDelegate : OFObject <OFApplicationDelegate, GTKWindowDelegate>

@property GTKWindow *window;

@property GTKImage *image;

@end