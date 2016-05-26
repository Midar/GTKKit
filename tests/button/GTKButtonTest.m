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
  
  window = [GTKWindow new];
  window.size = of_dimension(300,200);
  window.title = @"Hello, world!";
  window.delegate = self;
  
  button = [GTKButton new];
  button.target = self;
  button.action = @selector(buttonClicked:);
  button.label = @"Click me!";
  
  [window addWidget: button];
  
  return self;
}

- (void)applicationDidFinishLaunching {
  
  [window showAll];
  
  gtk_main();
}

- (void)buttonClicked:(id)sender {
  printf("Hello, world!\n");
}

- (void)applicationWillTerminate {
  gtk_main_quit();
}

- (void)windowWillClose:(GTKWindow *)sender {
  [OFApplication terminate];
}

@end