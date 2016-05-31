#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKScale.h"

static gboolean gtk_scale_value_changed(GtkScale *scale, GtkScrollType scroll, gdouble value, GTKScale *sender) {
  #pragma clang diagnostic push
  #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
  if([sender.target respondsToSelector: sender.action]) {
    [sender.target performSelector: sender.action withObject: sender];
  }
  #pragma clang diagnostic pop
  return FALSE;
}

@implementation GTKScale

- (id)createWidget {
  GtkAdjustment *adj = gtk_adjustment_new (0, 0, 0, 1.0, 1.0, 0);
	self.widget = gtk_scale_new (GTK_ORIENTATION_HORIZONTAL, adj);
  g_signal_connect(GTK_WIDGET (self.widget), "change-value", G_CALLBACK (gtk_scale_value_changed), (__bridge void*) self);
  return self;
}

- (id)init {
	self = [super init];
	return self;
}

@end
