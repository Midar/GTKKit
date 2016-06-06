#import "GTKKit.h"
#import "AppDelegate.h"

OF_APPLICATION_DELEGATE(AppDelegate)

@implementation AppDelegate
- init
{
  self = [super init];

  gtk_init(NULL,NULL);

  self.window = [GTKWindow new];
  self.window.size = of_dimension(300,200);

  // This makes the AppDelegate also act as the GTKWindowDelegate for the window.
  self.window.delegate = self;

  self.window.title = @"Hello, World!";

  return self;
}

- (void)applicationDidFinishLaunching
{
  [self.window showAll];

  gtk_main();
}

- (void)applicationWillTerminate
{
  gtk_main_quit();
}

// This demonstrates the use of a GTKWindowDelegate method. This makes the
// application exit when the window is closed.

- (void)windowWillClose:(GTKWindow *)sender
{
  [OFApplication terminate];
}

- (void)windowDidMinimize:(GTKWindow *)sender
{
  printf("Window was minimized.\n");
}

- (void)windowDidUnminimize:(GTKWindow *)sender
{
  printf("Window was unminimized.\n");
}
@end
