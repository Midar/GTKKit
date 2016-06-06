#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKSpinner.h"

@implementation GTKSpinner
- init
{
  self = [super init];
  self.widget = gtk_spinner_new();
  return self;
}

- (void)start {
  self.spinning = true;
  gtk_spinner_start(GTK_SPINNER(self.widget));
}

- (void)stop {
  self.spinning = false;
  gtk_spinner_stop(GTK_SPINNER(self.widget));
}
@end
