#import "GTKKit.h"
#import "AppDelegate.h"

OF_APPLICATION_DELEGATE(AppDelegate)

@implementation AppDelegate {
  GTKWindow *window;
}

- (id)init {
  gtk_init(NULL,NULL);
  self = [super init];
  
  window = [GTKWindow new];
  window.size = of_dimension(300,200);
  window.title = @"This window shouldn't be closable.";
  window.delegate = self;
  
  
  return self;
}

- (void)applicationDidFinishLaunching {
  [window showAll];
  
  gtk_main();
}

- (void)applicationWillTerminate {
  gtk_main_quit();
}

- (bool)windowShouldClose:(GTKWindow *)sender {
  return FALSE;
}

@end