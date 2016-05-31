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

static gchar* format_gtk_scale_value(GtkScale *scale, gdouble value, GTKScale *sender) {
  return g_strdup_printf ([sender.formatString UTF8String],
                          gtk_scale_get_digits (scale), value);
}

@implementation GTKScale

- (id)createWidget {
  GtkAdjustment *adj = gtk_adjustment_new (0, 0, 0, 1.0, 1.0, 0);
	self.widget = gtk_scale_new (GTK_ORIENTATION_HORIZONTAL, adj);
  gtk_scale_set_digits(GTK_SCALE(self.widget), 2);
  self.formatString = [OFString stringWithFormat: @"%%.%df", gtk_scale_get_digits(GTK_SCALE(self.widget))];
  gtk_scale_set_value_pos (GTK_SCALE(self.widget), GTK_POS_TOP);
  g_signal_connect(GTK_WIDGET (self.widget), "change-value", G_CALLBACK (gtk_scale_value_changed), (__bridge void*) self);
  g_signal_connect(GTK_WIDGET (self.widget), "format-value", G_CALLBACK (format_gtk_scale_value), (__bridge void*) self);
  return self;
}

- (id)init {
	self = [super init];
	return self;
}

@end
