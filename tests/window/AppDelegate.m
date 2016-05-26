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
  window.delegate = self;
  window.title = @"Hello, World!";
  
  window.onDestroy = ^ () {
    [OFApplication terminate];
  };
  
  return self;
}

- (void)applicationDidFinishLaunching {
  [window showAll];
  
  gtk_main();
}

- (void)applicationWillTerminate {
  gtk_main_quit();
}

@end