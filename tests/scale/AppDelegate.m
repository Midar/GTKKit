#import "GTKKit.h"
#import "AppDelegate.h"

OF_APPLICATION_DELEGATE(AppDelegate)

@implementation AppDelegate

- (id)init {
  gtk_init(NULL,NULL);
  self = [super init];
  
  self.window = [GTKWindow new];
  self.window.size = of_dimension(300,200);
  
  // This makes the AppDelegate also act as the GTKWindowDelegate for the window.
  self.window.delegate = self;
  
  self.window.title = @"Hello, World!";
  
  self.scale = [GTKScale new];
  self.scale.target = self;
  self.scale.action = @selector(scaleValueChanged:);
  self.scale.min = 0;
  self.scale.max = 100;
  self.scale.digits = 0;
  self.scale.stepSize = 10;
  [self.scale setFormatStringBefore: @"-->" after: @"<--"];
  
  [self.window addWidget: self.scale];
  
  return self;
}

- (void)applicationDidFinishLaunching {
  [self.window showAll];
  
  gtk_main();
}

- (void)applicationWillTerminate {
  gtk_main_quit();
}

// This demonstrates the use of a GTKWindowDelegate method. This makes the
// application exit when the window is closed.

- (void)windowWillClose:(GTKWindow *)sender {
  [OFApplication terminate];
}

- (void)scaleValueChanged:(GTKScale *)sender {
  printf("New formatted scale value: %s\n", [sender.formattedValue UTF8String]);
}


@end