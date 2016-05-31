#import "GTKKit.h"

@interface AppDelegate : OFObject <OFApplicationDelegate, GTKWindowDelegate>

@property GTKWindow *window;
@property GTKGrid *grid;
@property GTKButton *button;
@property GTKSpinner *spinner;

- (void)buttonClicked:(GTKButton *)sender;

@end