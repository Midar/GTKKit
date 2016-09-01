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

#import "GTKButton.h"
#import "GTKButton+Properties.h"

@implementation GTKButton (Properties)
- (void)setLabel: (OFString*)label
{
	gtk_button_set_label(GTK_BUTTON(self.widget), [label UTF8String]);
}

- (OFString*)label
{
	return @(gtk_button_get_label(GTK_BUTTON(self.widget)));
}

- (void)setReliefStyle: (GtkReliefStyle)relief
{
	gtk_button_set_relief(GTK_BUTTON(self.widget), relief);
}

- (GtkReliefStyle)reliefStyle
{
	return gtk_button_get_relief(GTK_BUTTON(self.widget));
}
@end
