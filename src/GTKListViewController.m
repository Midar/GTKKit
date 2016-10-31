/*! @file GTKListViewController.m
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

#import "GTKListViewController.h"
#import "GTKApplication.h"

#import "GTKTextField.h"

@implementation GTKListViewController
- init {
    self = [super init];
    [GTKApp.dispatch.gtk sync: ^{
        gtk_widget_destroy(self.contentView.mainWidget);

        _scrollWindow = gtk_scrolled_window_new(NULL, NULL);
        g_object_ref_sink(G_OBJECT(_scrollWindow));
        gtk_widget_show(_scrollWindow);

        self.contentView.mainWidget = gtk_list_box_new();
        g_object_ref_sink(G_OBJECT(self.contentView.mainWidget));
        gtk_widget_show(self.contentView.mainWidget);

        gtk_container_add(
            GTK_CONTAINER(_scrollWindow),
            self.contentView.mainWidget);

        gtk_container_add(
            GTK_CONTAINER(self.contentView.overlayWidget),
            _scrollWindow);
    }];
    return self;
}

- (void)reloadData
{
    [GTKApp.dispatch.gtk sync: ^{
        GList *children, *iter;
        children = gtk_container_get_children(GTK_CONTAINER(self.contentView.mainWidget));
        for(iter = children; iter != NULL; iter = g_list_next(iter)) {
            gtk_container_remove(
                GTK_CONTAINER(self.contentView.mainWidget),
                GTK_WIDGET(iter->data));
        }
        if (self.delegate == nil || self.dataSource == nil) {
            return;
        }
        g_list_free(children);
        int i = 0;

        _views = [OFMutableArray arrayWithCapacity: self.dataSource.numberOfRows];
        _headers = [OFMutableArray arrayWithCapacity: self.dataSource.numberOfRows];

        while (i < self.dataSource.numberOfRows) {
            GTKView *view = [self.dataSource viewForRow: i];
            [_views addObject: view];
            gtk_list_box_insert (
                GTK_LIST_BOX(self.contentView.mainWidget),
                view.overlayWidget,
                i);
            if ([self.delegate respondsToSelector: @selector(heightForRow:)]) {
                GtkListBoxRow *row = gtk_list_box_get_row_at_index(
                    GTK_LIST_BOX(self.contentView.mainWidget),
                    i);
                gtk_widget_set_size_request(
                    GTK_WIDGET(row),
                    -1,
                    [self.delegate heightForRow: i]);
            }
            i++;
        }
    }];
}
@end
