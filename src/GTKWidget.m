#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKWidget.h"
#import "typedefs.h"

@implementation GTKWidget
+ (instancetype)widgetFromGtkWidget:(GtkWidget *)w
{
	GTKWidget *newWidget = [self new];
	newWidget.widget = w;
	return newWidget;
}

- (void)dealloc
{
  if (self.widget != NULL)
    gtk_widget_destroy(GTK_WIDGET(self.widget));
}
@end
