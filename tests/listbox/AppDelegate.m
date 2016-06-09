#import "GTKKit.h"
#import "AppDelegate.h"

OF_APPLICATION_DELEGATE(AppDelegate)

@implementation AppDelegate
- init
{
  self = [super init];

  gtk_init(NULL,NULL);

  self.window = [GTKWindow new];
  self.window.size = of_dimension(200,80);
  self.window.delegate = self;
  self.window.title = @"List Box Test";

  self.scrollbox = [GTKScrolledWindow new];
  self.scrollbox.minContentHeight = 100;

  self.listbox = [GTKListBox new];
  self.listbox.expandHorizontal = true;
  self.listbox.expandVertical = true;
  self.listbox.marginStart = 5;
  self.listbox.marginEnd = 5;
  self.listbox.marginTop = 5;
  self.listbox.marginBottom = 5;
  self.listbox.target = self;
  self.listbox.action = @selector(rowSelectionUpdated:);

  [self.scrollbox addWidget: self.listbox];

  [self.window addWidget: self.scrollbox];

  self.label01 = [GTKLabel new];
  self.label02 = [GTKLabel new];
  self.label03 = [GTKLabel new];
  self.label04 = [GTKLabel new];
  self.label05 = [GTKLabel new];

  self.label01.label = @"Row one";
  self.label02.label = @"Row two";
  self.label03.label = @"Row three";
  self.label04.label = @"Row four";
  self.label05.label = @"Row five";

  self.label01.marginStart = 5;
  self.label01.marginEnd = 5;
  self.label01.marginTop = 5;
  self.label01.marginBottom = 5;

  self.label02.marginStart = 5;
  self.label02.marginEnd = 5;
  self.label02.marginTop = 5;
  self.label02.marginBottom = 5;

  self.label03.marginStart = 5;
  self.label03.marginEnd = 5;
  self.label03.marginTop = 5;
  self.label03.marginBottom = 5;

  self.label04.marginStart = 5;
  self.label04.marginEnd = 5;
  self.label04.marginTop = 5;
  self.label04.marginBottom = 5;

  self.label05.marginStart = 5;
  self.label05.marginEnd = 5;
  self.label05.marginTop = 5;
  self.label05.marginBottom = 5;

  [self.listbox appendWidget: self.label01];
  [self.listbox appendWidget: self.label02];
  [self.listbox appendWidget: self.label03];
  [self.listbox appendWidget: self.label04];
  [self.listbox appendWidget: self.label05];

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

- (void)windowWillClose:(GTKWindow *)sender
{
  [OFApplication terminate];
}

- (void)rowSelectionUpdated:(GTKListBox*)sender
{
  GTKLabel *label = (GTKLabel*)sender.widgetForSelectedRow;
  printf("Row selected: %s\n", [label.label UTF8String]);
}
@end
