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

#import "GTKListBox+Rows.h"

@implementation GTKListBox (Rows)
- (bool)rowSelectedAtIndex: (int)index
{
	if (index >= self.rowCount)
		@throw [GTKRowOutOfBoundsException new];

	GtkListBoxRow *row =
	    gtk_list_box_get_row_at_index(GTK_LIST_BOX(self.widget), index);
	return gtk_list_box_row_is_selected(GTK_LIST_BOX_ROW(row));
}

- (void)setRowHeaderAtIndex: (int)index
		   toWidget: (GTKWidget*)header
{
	if (index >= self.rowCount)
		@throw [GTKRowOutOfBoundsException new];

	GtkListBoxRow *row =
	    gtk_list_box_get_row_at_index(GTK_LIST_BOX(self.widget), index);
	gtk_list_box_row_set_header(GTK_LIST_BOX_ROW(row), header.widget);
}

- (bool)rowActivatableAtIndex: (int)index
{
	if (index >= self.rowCount)
		@throw [GTKRowOutOfBoundsException new];

	GtkListBoxRow *row =
	    gtk_list_box_get_row_at_index(GTK_LIST_BOX(self.widget), index);
	return gtk_list_box_row_get_activatable(GTK_LIST_BOX_ROW(row));
}

- (void)setRowActivatableAtIndex: (int)index
			      to: (bool)activatable
{
	if (index >= self.rowCount)
		@throw [GTKRowOutOfBoundsException new];

	GtkListBoxRow *row =
	    gtk_list_box_get_row_at_index(GTK_LIST_BOX(self.widget), index);
	gtk_list_box_row_set_activatable(GTK_LIST_BOX_ROW(row), activatable);
}

- (bool)rowSelectableAtIndex: (int)index
{
	if (index >= self.rowCount)
		@throw [GTKRowOutOfBoundsException new];

	GtkListBoxRow *row =
	    gtk_list_box_get_row_at_index(GTK_LIST_BOX(self.widget), index);
	return gtk_list_box_row_get_selectable(GTK_LIST_BOX_ROW(row));
}

- (void)setRowSelectableAtIndex: (int)index
			     to: (bool)selectable
{
	if (index >= self.rowCount)
		@throw [GTKRowOutOfBoundsException new];

	GtkListBoxRow *row =
	    gtk_list_box_get_row_at_index(GTK_LIST_BOX(self.widget), index);
	gtk_list_box_row_set_selectable(GTK_LIST_BOX_ROW(row), selectable);
}

- (void)rowChangedAtIndex: (int)index
{
	if (index >= self.rowCount)
		@throw [GTKRowOutOfBoundsException new];

	GtkListBoxRow *row =
	    gtk_list_box_get_row_at_index(GTK_LIST_BOX(self.widget), index);
	gtk_list_box_row_changed(GTK_LIST_BOX_ROW(row));
}
@end
