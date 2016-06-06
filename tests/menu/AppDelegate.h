#import "GTKKit.h"

@interface AppDelegate : OFObject <OFApplicationDelegate, GTKWindowDelegate>
@property GTKWindow *window;
@property GTKButton *button;
@property GTKMenu *menu;
@property GTKMenuItem *fooMenu;
@property GTKMenuItem *barMenu;
@property GTKMenuItem *bazMenu;
- (void)buttonClicked:(GTKButton *)sender;
- (void)fooMenuClicked:(GTKMenuItem *)sender;
- (void)barMenuClicked:(GTKMenuItem *)sender;
- (void)bazMenuClicked:(GTKMenuItem *)sender;
@end
