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

#import "GTKLevelBar.h"

@implementation GTKLevelBar (Properties)
- (GtkLevelBarMode)mode
{
  return gtk_level_bar_get_mode(GTK_LEVEL_BAR(self.widget));
}

- (void)setMode:(GtkLevelBarMode)mode
{
  gtk_level_bar_set_mode(GTK_LEVEL_BAR(self.widget), mode);
}

- (double)value
{
  return gtk_level_bar_get_value(GTK_LEVEL_BAR(self.widget));
}

- (void)setValue:(double)value
{
  gtk_level_bar_set_value(GTK_LEVEL_BAR(self.widget), value);
}

- (double)minValue
{
  return gtk_level_bar_get_min_value(GTK_LEVEL_BAR(self.widget));
}

- (void)setMinValue:(double)value
{
  gtk_level_bar_set_min_value(GTK_LEVEL_BAR(self.widget), value);
}

- (double)maxValue
{
  return gtk_level_bar_get_max_value(GTK_LEVEL_BAR(self.widget));
}

- (void)setMaxValue:(double)value
{
  gtk_level_bar_set_max_value(GTK_LEVEL_BAR(self.widget), value);
}

- (bool)inverted
{
  return gtk_level_bar_get_inverted(GTK_LEVEL_BAR(self.widget));
}

- (void)setInverted:(bool)inverted
{
  gtk_level_bar_set_inverted(GTK_LEVEL_BAR(self.widget), inverted);
}

- (GtkOrientation)orientation
{
  return gtk_orientable_get_orientation (GTK_ORIENTABLE (self.widget));
}

- (void)setOrientation:(GtkOrientation)orientation
{
  gtk_orientable_set_orientation (GTK_ORIENTABLE (self.widget), orientation);
}
@end
