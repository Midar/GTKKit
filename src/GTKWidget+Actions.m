#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKWidget.h"
#import "GTKWidget+Actions.h"

@implementation GTKWidget (Actions)
- (void)show
{
  gtk_widget_show(GTK_WIDGET(self.widget));
}

- (void)showAll
{
  gtk_widget_show_all(GTK_WIDGET(self.widget));
}

- (void)destroy
{
  gtk_widget_destroy(GTK_WIDGET(self.widget));
}

- (void)hide
{
  gtk_widget_hide(GTK_WIDGET(self.widget));
}

- (bool)activate
{
  return gtk_widget_activate(GTK_WIDGET(self.widget));
}

- (void)grabFocus
{
  gtk_widget_grab_focus(GTK_WIDGET(self.widget));
}

- (void)grabDefault
{
  gtk_widget_grab_default(GTK_WIDGET(self.widget));
}
@end
