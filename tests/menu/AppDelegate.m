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

  self.menu = [GTKMenu new];

  self.fooMenu = [GTKMenuItem menuItemWithLabel: @"Foo"];
  self.fooMenu.target = self;
  self.fooMenu.action = @selector(fooMenuClicked:);

  self.barMenu = [GTKMenuItem menuItemWithLabel: @"Bar"];
  self.barMenu.target = self;
  self.barMenu.action = @selector(barMenuClicked:);

  self.bazMenu = [GTKMenuItem menuItemWithLabel: @"Baz"];
  self.bazMenu.target = self;
  self.bazMenu.action = @selector(bazMenuClicked:);

  [self.menu appendMenuItem: self.fooMenu];
  [self.menu appendMenuItem: self.barMenu];
  [self.menu appendMenuItem: self.bazMenu];

  self.button = [GTKButton new];
  self.button.label = @"Click me!";
  self.button.target = self;
  self.button.action = @selector(buttonClicked:);

  [self.window addWidget: self.button];

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
  [self.menu popup];
}

- (void)fooMenuClicked:(GTKMenuItem *)sender
{
  printf("Foo Menu Item Clicked!\n");
}

- (void)barMenuClicked:(GTKMenuItem *)sender
{
  printf("Bar Menu Item Clicked!\n");
}

- (void)bazMenuClicked:(GTKMenuItem *)sender
{
  printf("Baz Menu Item Clicked!\n");
}
@end
