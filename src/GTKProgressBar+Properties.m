#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKProgressBar+Properties.h"

@implementation GTKProgressBar (Properties)
- (double)value
{
  return gtk_progress_bar_get_fraction(GTK_PROGRESS_BAR(self.widget));
}

- (void)setValue:(double) newValue
{
  gtk_progress_bar_set_fraction(GTK_PROGRESS_BAR(self.widget), newValue);
}

- (bool)inverted
{
  return gtk_progress_bar_get_inverted(GTK_PROGRESS_BAR(self.widget));
}

- (void)setInverted:(bool) newValue
{
  gtk_progress_bar_set_inverted(GTK_PROGRESS_BAR(self.widget), newValue);
}

- (bool)showText
{
  return gtk_progress_bar_get_show_text(GTK_PROGRESS_BAR(self.widget));
}

- (void)setShowText:(bool) newValue
{
  gtk_progress_bar_set_show_text(GTK_PROGRESS_BAR(self.widget), newValue);
}

- (OFString *)text
{
  return @(gtk_progress_bar_get_text(GTK_PROGRESS_BAR(self.widget)));
}

- (void)setText:(OFString *) newValue
{
  gtk_progress_bar_set_text(GTK_PROGRESS_BAR(self.widget),
      [newValue UTF8String]);
}

- (bool)ellipsize
{
  PangoEllipsizeMode ellip = \
      gtk_progress_bar_get_ellipsize(GTK_PROGRESS_BAR(self.widget));
  if (ellip == PANGO_ELLIPSIZE_NONE) {
    return false;
  } else {
    return true;
  }
}

- (void)setEllipsize:(bool) newValue
{
  if (newValue) {
    gtk_progress_bar_set_ellipsize(GTK_PROGRESS_BAR(self.widget),
        PANGO_ELLIPSIZE_END);
  } else {
    gtk_progress_bar_set_ellipsize(GTK_PROGRESS_BAR(self.widget),
        PANGO_ELLIPSIZE_NONE);
  }
}

- (double)pulseStep
{
  return gtk_progress_bar_get_pulse_step(GTK_PROGRESS_BAR(self.widget));
}

- (void)setPulseStep:(double) newValue
{
  gtk_progress_bar_set_pulse_step(GTK_PROGRESS_BAR(self.widget), newValue);
}
@end
