#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKRange.h"
#import "typedefs.h"

@implementation GTKRange
- (void)setFillLevel:(double)newValue
{
  gtk_range_set_fill_level(GTK_RANGE(self.widget), newValue);
}

- (double)fillLevel
{
  return gtk_range_get_fill_level(GTK_RANGE(self.widget));
}

- (void)setRestrictToFillLevel:(bool)newValue
{
  gtk_range_set_restrict_to_fill_level(GTK_RANGE(self.widget), newValue);
}

- (bool)restrictToFillLevel
{
  return gtk_range_get_restrict_to_fill_level(GTK_RANGE(self.widget));
}

- (void)setShowFillLevel:(bool)newValue
{
  gtk_range_set_show_fill_level(GTK_RANGE(self.widget), newValue);
}

- (bool)showFillLevel
{
  return gtk_range_get_show_fill_level(GTK_RANGE(self.widget));
}

- (void)setInverted:(bool)newValue
{
  gtk_range_set_inverted(GTK_RANGE(self.widget), newValue);
}

- (bool)inverted
{
  return gtk_range_get_inverted(GTK_RANGE(self.widget));
}

- (void)setValue:(double)newValue
{
  gtk_range_set_value(GTK_RANGE(self.widget), newValue);
}

- (double)value
{
  return gtk_range_get_value(GTK_RANGE(self.widget));
}

- (void)setStepSize:(double)newValue
{
  _stepSize = newValue;
  gtk_range_set_increments(GTK_RANGE(self.widget), newValue, newValue);
}

- (void)min:(double)min max:(double)max
{
  _min = min;
  _max = max;
  gtk_range_set_range(GTK_RANGE(self.widget), min, max);
}

- (double)min
{
  return _min;
}

- (void)setMin:(double)newValue
{
  [self min: newValue max: self.max ];
}

- (double)max
{
  return _max;
}

- (void)setMax:(double)newValue
{
  [self min: self.min max: newValue ];
}

- (int)roundDigits
{
  return gtk_range_get_round_digits(GTK_RANGE(self.widget));
}

- (void)setRoundDigits:(int)newValue
{
  gtk_range_set_round_digits(GTK_RANGE(self.widget), newValue);
}
@end
