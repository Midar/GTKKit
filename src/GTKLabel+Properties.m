#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKLabel+Properties.h"

@implementation GTKLabel (Properties)

- (OFString *)label {
	return [OFString stringWithUTF8String: gtk_label_get_text (GTK_LABEL (self.widget))];
}

- (void)setLabel:(OFString *)label {
	gtk_label_set_text (GTK_LABEL (self.widget), [label UTF8String]);
}

- (float)xAlign {
	float x;
	g_object_get (G_OBJECT (self.widget), "xalign", &x, NULL);
	return x;
}

- (float)yAlign {
	float y;
	g_object_get (G_OBJECT (self.widget), "yalign", &y, NULL);
	return y;
}

- (void)setXAlign:(float)xAlign {
	g_object_set (G_OBJECT (self.widget), "xalign", xAlign, NULL);
}

- (void)setYAlign:(float)yAlign {
	g_object_set (G_OBJECT (self.widget), "yalign", yAlign, NULL);
}

- (void)setJustify:(GtkJustification)jtype {
	gtk_label_set_justify (GTK_LABEL (self.widget), jtype);
}

- (GtkJustification)justify {
	return gtk_label_get_justify (GTK_LABEL (self.widget));
}

- (PangoEllipsizeMode)ellipsizeMode {
	return gtk_label_get_ellipsize (GTK_LABEL (self.widget));
}

- (void)setEllipsizeMode:(PangoEllipsizeMode)mode {
	gtk_label_set_ellipsize (GTK_LABEL (self.widget), mode);
}

- (int)desiredWidthInCharacters {
	return gtk_label_get_width_chars (GTK_LABEL (self.widget));
}

- (void)setDesiredWidthInCharacters:(int)width {
	gtk_label_set_width_chars (GTK_LABEL (self.widget), width);
}

- (void)setWrap:(bool)wrap {
	gtk_label_set_line_wrap (GTK_LABEL (self.widget), wrap);
}

- (bool)wrap {
	return gtk_label_get_line_wrap (GTK_LABEL (self.widget));
}

- (void)setLineWrapMode:(PangoWrapMode)mode {
	gtk_label_set_line_wrap_mode (GTK_LABEL (self.widget), mode);
}

- (PangoWrapMode)lineWrapMode {
	return gtk_label_get_line_wrap_mode (GTK_LABEL (self.widget));
}

- (bool)selectable {
	return gtk_label_get_selectable (GTK_LABEL (self.widget));
}

- (void)setSelectable:(bool)setting {
	gtk_label_set_selectable (GTK_LABEL (self.widget), setting);
}

- (bool)singleLineMode {
	return gtk_label_get_single_line_mode (GTK_LABEL (self.widget));
}

- (void)setSingleLineMode:(bool)setting {
	gtk_label_set_single_line_mode (GTK_LABEL (self.widget), setting);
}

- (double)angle {
	return gtk_label_get_angle (GTK_LABEL (self.widget));
}

- (void)setAngle:(double)angle {
	gtk_label_set_angle (GTK_LABEL (self.widget), angle);
}

@end
