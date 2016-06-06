#import "GTKExpander.h"

@implementation GTKExpander
- init
{
  self = [super init];
  self.widget = gtk_expander_new ("");
  return self;
}
@end
