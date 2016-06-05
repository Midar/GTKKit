#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKSeparator.h"

@implementation GTKSeparator

+ (id)separatorWithOrientation:(GtkOrientation)orientation {
  return [[self alloc] initWithOrientation: orientation];
}

- (id)initWithOrientation:(GtkOrientation)orientation {
  self = [self init];
  if (self) {
    self.widget = gtk_separator_new(orientation);
  }
  return self;
}

- (id)createWidget {
	return self;
}

@end
