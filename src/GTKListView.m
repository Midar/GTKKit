/*! @file GTKListView.m
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

#import "GTKListView.h"
#import "GTKApplication.h"
#import "GTKTextField.h"

@implementation GTKListView
- init {
	self = [super init];
	_views = [OFMutableArray arrayWithCapacity: self.dataSource.numberOfRows];
	[GTKApp.dispatch.gtk sync: ^{
		gtk_widget_destroy(self.mainWidget);
		g_object_unref(self.mainWidget);

		self.mainWidget = gtk_list_box_new();
		g_object_ref_sink(G_OBJECT(self.mainWidget));
		gtk_widget_show(self.mainWidget);

		_scrollWindow = gtk_scrolled_window_new(NULL, NULL);
		g_object_ref_sink(G_OBJECT(_scrollWindow));
		gtk_widget_show(_scrollWindow);

		gtk_container_add(
		    GTK_CONTAINER(_scrollWindow),
		    self.mainWidget);

		gtk_container_add(
		    GTK_CONTAINER(self.overlayWidget),
		    _scrollWindow);

	}];
	return self;
}

- (void)dealloc
{
	g_object_unref(_scrollWindow);
}

- (void)reloadData
{
	[GTKApp.dispatch.gtk sync: ^{
		GList *children, *iter;
		children = gtk_container_get_children(GTK_CONTAINER(self.mainWidget));
		for(iter = children; iter != NULL; iter = g_list_next(iter)) {
			gtk_container_remove(
			    GTK_CONTAINER(self.mainWidget),
			    GTK_WIDGET(iter->data));
		}
		g_list_free(children);

		for (GTKView *view in _views) {
			[_views removeObject: view];
		}

		if (self.delegate == nil || self.dataSource == nil) {
			return;
		}

		for (int i = 0; i < self.dataSource.numberOfRows; i++) {
			GTKView *view = [self.dataSource viewForRow: i];
			[_views addObject: view];
			gtk_list_box_insert (
			    GTK_LIST_BOX(self.mainWidget),
			    view.overlayWidget,
			    i);
			if ([self.delegate respondsToSelector: @selector(heightForRow:)]) {
				GtkListBoxRow *row = gtk_list_box_get_row_at_index(
				    GTK_LIST_BOX(self.mainWidget),
				    i);
				gtk_widget_set_size_request(
				    GTK_WIDGET(row),
				    -1,
				    [self.delegate heightForRow: i]);
			}
		}
	}];
}
@end
