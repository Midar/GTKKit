#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKRange.h"
#import "typedefs.h"

@implementation GTKRange

@dynamic fillLevel;
@dynamic restrictToFillLevel;
@dynamic showFillLevel;
@dynamic inverted;
@dynamic value;
@dynamic roundDigts;

- (void)setFillLevel:(double)newValue {
  gtk_range_set_fill_level(GTK_RANGE(self.widget), newValue);
}

- (double)getFillLevel {
  return gtk_range_get_fill_level(GTK_RANGE(self.widget));
}

- (void)setRestrictToFillLevel:(bool)newValue {
  gtk_range_set_restrict_to_fill_level(GTK_RANGE(self.widget), newValue);
}

- (bool)restrictToFillLevel {
  return gtk_range_get_restrict_to_fill_level(GTK_RANGE(self.widget));
}

- (void)showFillLevel:(bool)newValue {
  gtk_range_set_show_fill_level(GTK_RANGE(self.widget), newValue);
}

- (bool)showFillLevel {
  return gtk_range_get_show_fill_level(GTK_RANGE(self.widget));
}

- (void)inverted:(bool)newValue {
  gtk_range_set_inverted(GTK_RANGE(self.widget), newValue);
}

- (bool)inverted {
  return gtk_range_get_inverted(GTK_RANGE(self.widget));
}

- (void)setValue:(double)newValue {
  gtk_range_set_value(GTK_RANGE(self.widget), newValue);
}

- (double)getValue {
  return gtk_range_get_value(GTK_RANGE(self.widget));
}

- (void)setStepSize:(double)newValue {
  _stepSize = newValue;
  gtk_range_set_increments(GTK_RANGE(self.widget), newValue, newValue);
}

- (void)setMin:(double)newValue {
  _min = newValue;
  gtk_range_set_range(GTK_RANGE(self.widget), newValue, self.max);
}

- (void)setMax:(double)newValue {
  _max = newValue;
  gtk_range_set_range(GTK_RANGE(self.widget), self.min, newValue);
}

- (int)getRoundDigits {
  return gtk_range_get_round_digits(GTK_RANGE(self.widget));
}

- (void)setRoundDigits:(int)newValue {
  gtk_range_set_round_digits(GTK_RANGE(self.widget), newValue);
}

@end
