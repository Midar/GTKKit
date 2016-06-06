#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKContainer+Properties.h"

@implementation GTKContainer (Properties)
- (void)setBorderWidth:(unsigned int)borderWidth
{
	gtk_container_set_border_width (GTK_CONTAINER (self.widget), borderWidth);
}

- (unsigned int)borderWidth
{
	return gtk_container_get_border_width (GTK_CONTAINER (self.widget));
}
@end
