#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKHeaderBar+Properties.h"

@implementation GTKHeaderBar (Properties)

@dynamic title;
@dynamic subtitle;
@dynamic hasSubtitle;
@dynamic showCloseButton;
@dynamic decorationLayout;

- (OFString *)title {
  return @(gtk_header_bar_get_title(GTK_HEADER_BAR(self.widget)));
}

- (void)setTitle:(OFString *)title {
  gtk_header_bar_set_title(GTK_HEADER_BAR(self.widget), [title UTF8String]);
}

- (OFString *)subtitle {
  return @(gtk_header_bar_get_subtitle(GTK_HEADER_BAR(self.widget)));
}

- (void)setSubtitle:(OFString *)subtitle {
  gtk_header_bar_set_subtitle(GTK_HEADER_BAR(self.widget), [subtitle UTF8String]);
}

- (bool)hasSubtitle {
  return gtk_header_bar_get_has_subtitle(GTK_HEADER_BAR(self.widget));
}

- (void)setHasSubtitle:(bool)subtitle {
  gtk_header_bar_set_has_subtitle(GTK_HEADER_BAR(self.widget), subtitle);
}

- (bool)showCloseButton {
  return gtk_header_bar_get_show_close_button(GTK_HEADER_BAR(self.widget));
}

- (void)setShowCloseButton:(bool)show {
  gtk_header_bar_set_show_close_button(GTK_HEADER_BAR(self.widget), show);
}

- (OFString *)decorationLayout {
  return @(gtk_header_bar_get_decoration_layout(GTK_HEADER_BAR(self.widget)));
}

- (void)setDecorationLayour:(OFString *)layout {
  gtk_header_bar_set_decoration_layout(GTK_HEADER_BAR(self.widget), [layout UTF8String]);
}

@end
