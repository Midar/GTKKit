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

#import "GTKRange.h"

@implementation GTKRange
- (void)setFillLevel: (double)newValue
{
	gtk_range_set_fill_level(GTK_RANGE(self.widget), newValue);
}

- (double)fillLevel
{
	return gtk_range_get_fill_level(GTK_RANGE(self.widget));
}

- (void)setRestrictToFillLevel: (bool)newValue
{
	gtk_range_set_restrict_to_fill_level(GTK_RANGE(self.widget), newValue);
}

- (bool)restrictToFillLevel
{
	return gtk_range_get_restrict_to_fill_level(GTK_RANGE(self.widget));
}

- (void)setShowFillLevel: (bool)newValue
{
	gtk_range_set_show_fill_level(GTK_RANGE(self.widget), newValue);
}

- (bool)showFillLevel
{
	return gtk_range_get_show_fill_level(GTK_RANGE(self.widget));
}

- (void)setInverted: (bool)newValue
{
	gtk_range_set_inverted(GTK_RANGE(self.widget), newValue);
}

- (bool)inverted
{
	return gtk_range_get_inverted(GTK_RANGE(self.widget));
}

- (void)setValue: (double)newValue
{
	gtk_range_set_value(GTK_RANGE(self.widget), newValue);
}

- (double)value
{
	return gtk_range_get_value(GTK_RANGE(self.widget));
}

- (void)setStepSize: (double)newValue
{
	_stepSize = newValue;
	gtk_range_set_increments(GTK_RANGE(self.widget), newValue, newValue);
}

- (void)setMinValue: (double)minValue
	   maxValue: (double)maxValue
{
	_min = minValue;
	_max = maxValue;
	gtk_range_set_range(GTK_RANGE(self.widget), minValue, maxValue);
}

- (double)minValue
{
	return _min;
}

- (void)setMinValue: (double)newValue
{
	[self setMinValue: newValue
		 maxValue: self.maxValue];
}

- (double)maxValue
{
	return _max;
}

- (void)setMaxValue: (double)newValue
{
	[self setMinValue: self.minValue
		 maxValue: newValue];
}

- (int)roundDigits
{
	return gtk_range_get_round_digits(GTK_RANGE(self.widget));
}

- (void)setRoundDigits: (int)newValue
{
	gtk_range_set_round_digits(GTK_RANGE(self.widget), newValue);
}

- (GtkOrientation)orientation
{
	return gtk_orientable_get_orientation(GTK_ORIENTABLE(self.widget));
}

- (void)setOrientation: (GtkOrientation)orientation
{
	gtk_orientable_set_orientation(GTK_ORIENTABLE(self.widget),
	    orientation);
}
@end
