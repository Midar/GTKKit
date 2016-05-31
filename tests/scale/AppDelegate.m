#import "GTKKit.h"
#import "AppDelegate.h"

OF_APPLICATION_DELEGATE(AppDelegate)

@implementation AppDelegate {
  GTKWindow *window;
  GTKScale *scale;
}

- (id)init {
  gtk_init(NULL,NULL);
  self = [super init];
  
  window = [GTKWindow new];
  window.size = of_dimension(300,200);
  
  // This makes the AppDelegate also act as the GTKWindowDelegate for the window.
  window.delegate = self;
  
  window.title = @"Hello, World!";
  
  scale = [GTKScale new];
  scale.target = self;
  scale.action = @selector(scaleValueChanged:);
  scale.min = 0;
  scale.max = 200;
  
  [window addWidget: scale];
  
  return self;
}

- (void)applicationDidFinishLaunching {
  [window showAll];
  
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
  printf("New scale value: %f\n", sender.value);
}


@end