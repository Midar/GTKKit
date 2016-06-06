#import "GTKKit.h"
#import "AppDelegate.h"

OF_APPLICATION_DELEGATE(AppDelegate)

@implementation AppDelegate
- init
{
  self = [super init];
    gtk_init(NULL,NULL);

  self.window = [GTKWindow new];
  self.window.size = of_dimension(200,100);
  // This makes the AppDelegate also act as the GTKWindowDelegate for the window.
  self.window.delegate = self;
  self.window.title = @"Hello, World!";

  self.grid = [GTKGrid new];
  [self.window addWidget: self.grid];

  self.button = [GTKButton new];
  self.button.target = self;
  self.button.action = @selector(buttonClicked:);
  self.button.marginStart = 10;
  self.button.marginEnd = 10;
  self.button.marginBottom = 10;
  self.button.expandHorizontal = true;

  self.spinner = [GTKSpinner new];
  self.spinner.marginStart = 10;
  self.spinner.marginEnd = 10;
  self.spinner.marginTop = 10;
  self.spinner.marginBottom = 10;
  self.spinner.widthRequest = 24;
  self.spinner.heightRequest = 24;

  [self.grid attachWidget: self.spinner
                     left: 1
                      top: 1
                    width: 1
                   height: 1];

  [self.grid attachWidget: self.button
                     left: 1
                      top: 2
                    width: 1
                   height: 1];

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

- (void)buttonClicked:(GTKButton *)sender
{
  if (self.spinner.spinning) {
    [self.spinner stop];
  } else {
    [self.spinner start];
  }
}
@end
