/*! @file GTKLinearViewController.m
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

#import "GTKLinearViewController.h"
#import "GTKApplication.h"

@implementation GTKLinearViewController
- init
{
    self = [super init];
    _views = [OFMutableArray new];
    [GTKApp.dispatch.gtk sync: ^{
        gtk_widget_destroy(self.contentView.mainWidget);
        self.contentView.mainWidget = gtk_grid_new();
        gtk_grid_set_row_homogeneous(
            GTK_GRID(self.contentView.mainWidget),
            false);
        gtk_grid_set_column_homogeneous(
            GTK_GRID(self.contentView.mainWidget),
            false);
        gtk_grid_set_row_spacing(
            GTK_GRID(self.contentView.mainWidget),
            0);
        gtk_grid_set_column_spacing(
            GTK_GRID(self.contentView.mainWidget),
            0);
    }];

    self.orientation = GTKOrientationVertical;
    return self;
}

- (void)addView:(nonnull GTKView *)view
{
    if ([_views containsObject: view]) {
        return;
    }
    [_views addObject: view];
    [GTKApp.dispatch.gtk sync: ^{
        gtk_container_add(
            GTK_CONTAINER(self.contentView.mainWidget),
            view.overlayWidget);
    }];
}

- (void)removeView:(nonnull GTKView *)view
{
    if (![_views containsObject: view]) {
        return;
    }
    [_views removeObject: view];
    [GTKApp.dispatch.gtk sync: ^{
        gtk_container_remove(
            GTK_CONTAINER(self.contentView.mainWidget),
            view.overlayWidget);
    }];
}

- (void)removeAllViews
{
    for (GTKView *view in _views) {
        [self removeView: view];
    }
}

- (GTKOrientation)orientation
{
    return _orientation;
}

- (void)setOrientation:(GTKOrientation)orientation
{
    if (_orientation == orientation) {
        return;
    }
    _orientation = orientation;
    [GTKApp.dispatch.gtk sync: ^{
        gtk_orientable_set_orientation(
            GTK_ORIENTABLE(self.contentView.mainWidget),
            (GtkOrientation)(orientation));
        for (GTKView *view in _views) {
            gtk_container_remove(
                GTK_CONTAINER(self.contentView.mainWidget),
                view.overlayWidget);
        }
        for (GTKView *view in _views) {
            gtk_container_add(
                GTK_CONTAINER(self.contentView.mainWidget),
                view.overlayWidget);
        }
    }];
}
@end
