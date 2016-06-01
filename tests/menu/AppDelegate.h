#import "GTKKit.h"
#import "MenuExample.h"

@interface AppDelegate : OFObject <OFApplicationDelegate, GTKWindowDelegate>

@property GTKWindow *window;
@property MenuExample *menu;
@property GTKButton *button;

- (void)buttonClicked:(GTKButton *)sender;

- (void)fooMenuClicked:(GTKMenuItem *)sender;

- (void)barMenuClicked:(GTKMenuItem *)sender;

- (void)bazMenuClicked:(GTKMenuItem *)sender;

@end