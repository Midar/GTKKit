#import "GTKKit.h"
#import "AppDelegate.h"

OF_APPLICATION_DELEGATE(AppDelegate)

@implementation AppDelegate
- init
{
  self = [super init];

  gtk_init(NULL, NULL);

  self.window = [GTKWindow new];
  self.window.size = of_dimension(300,200);
  self.window.title = @"Hello, world!";
  self.window.delegate = self;

  self.button = [GTKToggleButton new];
  self.button.target = self;
  self.button.action = @selector(buttonToggled:);
  self.button.label = @"Click me!";

  [self.window addWidget: self.button];

  return self;
}

- (void)applicationDidFinishLaunching
{

  [self.window showAll];

  gtk_main();
}

- (void)buttonToggled:(id)sender
{
  if (self.button.active) {
    printf("Button is active.\n");
  } else {
    printf("Button is inactive.\n");
  }
}

- (void)applicationWillTerminate
{
  gtk_main_quit();
}

- (void)windowWillClose:(GTKWindow *)sender
{
  [OFApplication terminate];
}
@end
