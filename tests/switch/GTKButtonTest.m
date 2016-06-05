#import "GTKKit.h"
#import "GTKButtonTest.h"

OF_APPLICATION_DELEGATE(GTKButtonTest)

@implementation GTKButtonTest

- (id)init {
  gtk_init(NULL, NULL);
  
  self = [super init];
  
  self.window = [GTKWindow new];
  self.window.size = of_dimension(300,200);
  self.window.title = @"Hello, world!";
  self.window.delegate = self;
  
  self.gswitch = [GTKSwitch new];
  
  [self.window addWidget: self.gswitch];
  
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