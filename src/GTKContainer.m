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

#import "GTKContainer.h"

@implementation GTKContainer
- (void)addWidget: (GTKWidget*)childWidget
{
	childWidget.parent = self;
	gtk_container_add(GTK_CONTAINER(self.widget), [childWidget widget]);
}

- (void)removeWidget: (GTKWidget*)childWidget
{
	childWidget.parent = NULL;
	gtk_container_remove(GTK_CONTAINER(self.widget), [childWidget widget]);
}

- (void)addAll: (OFArray*)childWidgets
{
	for (id childWidget in childWidgets)
		[self addWidget: childWidget];
}

- (void)setBorderWidth: (unsigned int)borderWidth
{
	gtk_container_set_border_width(GTK_CONTAINER(self.widget), borderWidth);
}

- (unsigned int)borderWidth
{
	return gtk_container_get_border_width(GTK_CONTAINER(self.widget));
}
@end
