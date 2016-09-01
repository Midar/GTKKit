/*
 * Copyright (c) 2014, 2015, 2016
 *   Kyle Cardoza <Kyle.Cardoza@icloud.com>
 *
 * All rights reserved.
 *
 * This file is part of GTKKit. It may be distributed under the terms of the
 * 2-clause BSD License, which can be found in the file COPYING.BSD included in
 * the packaging of this file.
 *
 * Alternatively, it may be distributed under the terms of the GNU Lesser
 * General Public License, either version 2 or 3, which can be found in the
 * files COPYING.LGPL2 and COPYING.LGPL3, respectively, both also included in
 * the packaging of this file.
 */

#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKScale.h"
#import "GTKScale+Properties.h"

@implementation GTKScale (Properties)
- (bool)showValue
{
	return gtk_scale_get_digits(GTK_SCALE(self.widget));
}

- (void)setShowValue: (bool)newValue
{
	gtk_scale_set_draw_value(GTK_SCALE(self.widget), newValue);
}

- (bool)hasOrigin
{
	return gtk_scale_get_has_origin(GTK_SCALE(self.widget));
}

- (void)setHasOrigin: (bool)newValue
{
	gtk_scale_set_has_origin(GTK_SCALE(self.widget), newValue);
}

- (GtkPositionType)valuePosition
{
	return gtk_scale_get_value_pos(GTK_SCALE(self.widget));
}

- (void)setValuePosition: (GtkPositionType)newValue
{
	gtk_scale_set_value_pos(GTK_SCALE(self.widget), newValue);
}

- (void)addMarkAtValue: (double)value
	  withPosition: (GtkPositionType)position
	      withText: (OFString*)text
{
	gtk_scale_add_mark(GTK_SCALE(self.widget),
	    value, position, [text UTF8String]);
}

- (void)addMarkAtValue: (double)value
{
	gtk_scale_add_mark(GTK_SCALE(self.widget),
	    value, self.valuePosition, NULL);
}

- (void)addMarkAtValue: (double)value
	      withText: (OFString*)text
{
	gtk_scale_add_mark(GTK_SCALE(self.widget), value, self.valuePosition,
	    [text UTF8String]);
}

- (void)addMarkAtValue: (double)value
          withPosition: (GtkPositionType)position
{
	gtk_scale_add_mark(GTK_SCALE(self.widget), value, position, NULL);
}

- (void)clearMarks
{
	gtk_scale_clear_marks(GTK_SCALE(self.widget));
}

- (OFString*)formattedValue
{
	return [OFString stringWithFormat:
	    (OFConstantString*)self.formatString, self.value];
}
@end
