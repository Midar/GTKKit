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
  
  self.image = [GTKImage new];
  
  [self.window addWidget: self.image];
  
  
  return self;
}

- (void)applicationDidFinishLaunching {
  [self.window showAll];
  
  gtk_main();
}

- (void)applicationWillTerminate {
  gtk_main_quit();
}

- (void)windowWillClose:(GTKWindow *)sender {
  [OFApplication terminate];
}

@end