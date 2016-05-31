#import "GTKKit.h"

@interface AppDelegate : OFObject <OFApplicationDelegate, GTKWindowDelegate>

@property GTKWindow *window;
@property GTKGrid *grid;
@property GTKProgressBar *pbar;
@property GTKButton *button;
@property GTKLabel *label;

@end