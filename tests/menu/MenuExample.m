#import "GTKKit.h"
#import "MenuExample.h"
#import "AppDelegate.h"

@implementation MenuExample

- (id)init {
  self = [super init];
  if (self) {
    
    self.fooMenu = [GTKMenuItem menuItemWithLabel: @"Foo"];
    self.barMenu = [GTKMenuItem menuItemWithLabel: @"Bar"];
    self.bazMenu = [GTKMenuItem menuItemWithLabel: @"Baz"];
        
    [self appendMenuItem: self.fooMenu];
    [self appendMenuItem: self.barMenu];
    [self appendMenuItem: self.bazMenu];
    
  }
  return self;
}

@end