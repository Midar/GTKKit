#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKWidget+Properties.h"
#import "GTKWidget.h"

@implementation GTKWidget (Properties)

- (void)setName:(OFString *)name {
	gtk_widget_set_name(GTK_WIDGET (self.widget), [name UTF8String]);
}

- (OFString *)name {
	return @(gtk_widget_get_name(GTK_WIDGET (self.widget)));
}

- (bool)isFocus {
	return gtk_widget_is_focus (GTK_WIDGET (self.widget));
}

- (void)setSensitive:(bool)sensitive {
	gtk_widget_set_sensitive (GTK_WIDGET (self.widget), sensitive);
}

- (bool)sensitive {
	return gtk_widget_get_sensitive (GTK_WIDGET (self.widget));
}

- (bool)effectiveSensitivity {
	return gtk_widget_is_sensitive (GTK_WIDGET (self.widget));
}

- (double)opacity {
	return gtk_widget_get_opacity (GTK_WIDGET (self.widget));
}

- (void)setOpacity:(double)opacity {
	gtk_widget_set_opacity (GTK_WIDGET (self.widget), opacity);
}

- (GtkAlign)horizontalAlign {
  return gtk_widget_get_halign(GTK_WIDGET(self.widget));
}

- (void)setHorizontalAlign:(GtkAlign)align {
  gtk_widget_set_halign(GTK_WIDGET(self.widget), align);
}

- (GtkAlign)verticalAlign {
  return gtk_widget_get_valign(GTK_WIDGET(self.widget));
}

- (void)setVerticalAlign:(GtkAlign)align {
  gtk_widget_set_valign(GTK_WIDGET(self.widget), align);
}

- (int)marginStart {
  return gtk_widget_get_margin_start(GTK_WIDGET(self.widget));
}

- (void)setMarginStart:(int)margin {
  gtk_widget_set_margin_start(GTK_WIDGET(self.widget), margin);
}

- (int)marginEnd {
  return gtk_widget_get_margin_end(GTK_WIDGET(self.widget));
}

- (void)setMarginEnd:(int)margin {
  gtk_widget_set_margin_end(GTK_WIDGET(self.widget), margin);
}

- (int)marginTop {
  return gtk_widget_get_margin_top(GTK_WIDGET(self.widget));
}

- (void)setMarginTop:(int)margin {
  gtk_widget_set_margin_top(GTK_WIDGET(self.widget), margin);
}

- (int)marginBottom {
  return gtk_widget_get_margin_bottom(GTK_WIDGET(self.widget));
}

- (void)setMarginBottom:(int)margin {
  gtk_widget_set_margin_bottom(GTK_WIDGET(self.widget), margin);
}

- (bool)expandHorizontal {
  return gtk_widget_get_hexpand(GTK_WIDGET(self.widget));
}

- (void)setExpandHorizontal:(bool)expand {
  gtk_widget_set_hexpand(GTK_WIDGET(self.widget), expand);
}

- (bool)expandVertical {
  return gtk_widget_get_vexpand(GTK_WIDGET(self.widget));
}

- (void)setExpandVertical:(bool)expand {
  gtk_widget_set_vexpand(GTK_WIDGET(self.widget), expand);
}

@end
