#import "GTKKit.h"
#import "GTKButtonTest.h"

OF_APPLICATION_DELEGATE(GTKButtonTest)

@implementation GTKButtonTest {
  GTKWindow *window;
  GTKButton *button;
}


- (id)init {
  gtk_init(NULL, NULL);
  self = [super init];
  return self;
}

- (void)applicationDidFinishLaunching {
  
  window = [GTKWindow new];
  window.size = of_dimension(300,200);
  window.onDestroy = ^ () {
    exit(0);
  };
  
  button = [GTKButton new];
  button.target = self;
  button.action = @selector(buttonClicked:);
  button.label = @"Click me!";
  
  [window addWidget: button];
  
  [window showAll];
  
  gtk_main();
}

- (void)buttonClicked:(id)sender {
  printf("Hello, world!\n");
}

@end