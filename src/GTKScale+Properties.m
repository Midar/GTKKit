#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKScale.h"
#import "GTKScale+Properties.h"

@implementation GTKScale (Properties)

@dynamic digits;
@dynamic drawValue;

- (int)getDigits {
  return gtk_scale_get_digits(GTK_SCALE(self.widget));
}

- (void)setDigits:(int)newValue {
  gtk_scale_set_digits(GTK_SCALE(self.widget), newValue);
}

- (bool)getDrawValue {
  return gtk_scale_get_digits(GTK_SCALE(self.widget));
}

- (void)setDrawValue:(bool)newValue {
  gtk_scale_set_draw_value(GTK_SCALE(self.widget), newValue);
}

@end
