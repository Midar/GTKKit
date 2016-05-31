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
  
  self.button = [GTKToggleButton new];
  self.button.target = self;
  self.button.action = @selector(buttonToggled:);
  self.button.label = @"Click me!";
  
  [self.window addWidget: self.button];
  
  return self;
}

- (void)applicationDidFinishLaunching {
  
  [self.window showAll];
  
  gtk_main();
}

- (void)buttonToggled:(id)sender {
  if (self.button.active) {
    printf("Button is active.\n");
  } else {
    printf("Button is inactive.\n");
  }
}

- (void)applicationWillTerminate {
  gtk_main_quit();
}

- (void)windowWillClose:(GTKWindow *)sender {
  [OFApplication terminate];
}

@end