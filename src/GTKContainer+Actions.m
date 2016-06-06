#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKContainer+Actions.h"

@implementation GTKContainer (Actions)
- (void)addWidget: (GTKWidget*)childWidget
{
  gtk_container_add(GTK_CONTAINER(self.widget), [childWidget widget]);
}

- (void)removeWidget: (GTKWidget*)childWidget
{
  gtk_container_remove(GTK_CONTAINER(self.widget), [childWidget widget]);
}

- (void)addAll: (OFArray*)childWidgets
{
  for (id childWidget in childWidgets)
    [self addWidget: childWidget];
}
@end
