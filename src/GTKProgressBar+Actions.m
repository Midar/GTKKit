#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKProgressBar+Actions.h"

@implementation GTKProgressBar (Actions)
- (void)pulse
{
  gtk_progress_bar_pulse(GTK_PROGRESS_BAR(self.widget));
}
@end
