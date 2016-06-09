#import "GTKExpander+Properties.h"

@implementation GTKExpander (Properties)
- (OFString *)label
{
  return [OFString stringWithUTF8String:
      gtk_expander_get_label (GTK_EXPANDER (self.widget))];
}

- (void)setLabel:(OFString *)label
{
  gtk_expander_set_label (GTK_EXPANDER (self.widget), [label UTF8String]);
}

+ (instancetype)expanderWithLabel:(OFString *)label
{
  return [[self alloc] initWithLabel: label];
}

- initWithLabel:(OFString *)label {
  self = [self init];
  self.label = label;
  return self;
}

- (bool)expanded
{
  return gtk_expander_get_expanded (GTK_EXPANDER (self.widget));
}

- (void)setExpanded:(bool)newValue
{
  gtk_expander_set_expanded (GTK_EXPANDER (self.widget), newValue);
}

- (int)spacing
{
  return gtk_expander_get_spacing (GTK_EXPANDER (self.widget));
}

- (void)setSpacing:(int)newValue
{
  gtk_expander_set_spacing (GTK_EXPANDER (self.widget), newValue);
}

- (bool)resizeToplevel
{
  return gtk_expander_get_resize_toplevel (GTK_EXPANDER (self.widget));
}

- (void)setResizeToplevel:(bool)newValue
{
  gtk_expander_set_resize_toplevel (GTK_EXPANDER (self.widget), newValue);
}
@end
