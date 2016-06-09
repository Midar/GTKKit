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

#import "GTKToggleButton+Properties.h"

@implementation GTKToggleButton (Properties)
- (void)setDrawIndicator:(bool) newValue
{
  gtk_toggle_button_set_mode(GTK_TOGGLE_BUTTON(self.widget), newValue);
}

- (bool)drawIndicator
{
  return gtk_toggle_button_get_mode(GTK_TOGGLE_BUTTON(self.widget));
}

- (void)setActive:(bool) newValue
{
  gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(self.widget), newValue);
}

- (bool)active
{
  return gtk_toggle_button_get_active(GTK_TOGGLE_BUTTON(self.widget));
}

- (void)setInconsistent:(bool) newValue
{
  gtk_toggle_button_set_inconsistent(GTK_TOGGLE_BUTTON(self.widget), newValue);
}

- (bool)inconsistent
{
  return gtk_toggle_button_get_inconsistent(GTK_TOGGLE_BUTTON(self.widget));
}
@end
