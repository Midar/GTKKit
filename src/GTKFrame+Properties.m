#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKFrame+Properties.h"

@implementation GTKFrame (Properties)
- (OFString *)label
{
	return @(gtk_frame_get_label (GTK_FRAME (self.widget)));
}

- (void)setLabel:(OFString *)label
{
	gtk_frame_set_label (GTK_FRAME (self.widget), [label UTF8String]);
}

- (GTKWidget *)labelWidget
{
	return [GTKWidget widgetFromGtkWidget: gtk_frame_get_label_widget (GTK_FRAME (self.widget))];
}

- (void)setLabelWidget:(GTKWidget *)labelWidget
{
	gtk_frame_set_label_widget (GTK_FRAME (self.widget), [labelWidget widget]);
}

- (void)setXAlign:(float)xAlign
{
	g_object_set (G_OBJECT (self.widget), "label-xalign", xAlign, NULL);
}

- (float)xAlign
{
	float x;
	g_object_get (G_OBJECT (self.widget), "label-xalign", &x, NULL);
	return x;
}

- (void)setYAlign:(float)yAlign
{
	g_object_set (G_OBJECT (self.widget), "label-yalign", yAlign, NULL);
}

- (float)yAlign
{
	float y;
	g_object_get (G_OBJECT (self.widget), "label-yalign", &y, NULL);
	return y;
}
@end
