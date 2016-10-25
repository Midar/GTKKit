/*! @file GTKSplitViewController.m
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

#import "GTKSplitViewController.h"
#import "GTKApplication.h"

@interface GTKSplitViewController ()
@property bool dividerInitialized;
@end

static void
realize_handler(GtkWidget *widget, GTKSplitViewController *vc)
{
    vc.dividerPosition = vc.dividerPosition;
}

@implementation GTKSplitViewController
- init
{
    self = [super init];
    self.dividerInitialized = false;
    _topLeftView = [GTKView new];
    _bottomRightView = [GTKView new];

    [GTKApp.dispatch.gtk sync: ^{
        gtk_widget_destroy(self.contentView.mainWidget);
        self.contentView.mainWidget = gtk_paned_new(GTK_ORIENTATION_HORIZONTAL);
        gtk_paned_set_wide_handle(GTK_PANED(self.contentView.mainWidget), true);

        g_signal_connect(
			G_OBJECT(self.contentView.overlayWidget),
			"realize",
			G_CALLBACK(realize_handler),
			(__bridge gpointer)(self));

        gtk_container_add(
            GTK_CONTAINER(self.contentView.overlayWidget),
            self.contentView.mainWidget);

        gtk_widget_show(self.contentView.mainWidget);

        _topLeftFrame = gtk_frame_new(NULL);
        _bottomRightFrame = gtk_frame_new(NULL);

        gtk_frame_set_shadow_type(
            GTK_FRAME(_topLeftFrame),
            GTK_SHADOW_IN);
        gtk_frame_set_shadow_type(
            GTK_FRAME(_bottomRightFrame),
            GTK_SHADOW_IN);

        gtk_paned_add1(
            GTK_PANED(self.contentView.mainWidget),
            _topLeftFrame);
        gtk_widget_show(_topLeftFrame);

        gtk_paned_add2(
            GTK_PANED(self.contentView.mainWidget),
            _bottomRightFrame);
        gtk_widget_show(_bottomRightFrame);

        gtk_container_child_set(
            GTK_CONTAINER(self.contentView.mainWidget),
            _topLeftFrame,
            "shrink", true,
            "resize", true,
            NULL);
        gtk_container_child_set(
            GTK_CONTAINER(self.contentView.mainWidget),
            _bottomRightFrame,
            "shrink", true,
            "resize", true,
            NULL);

        gtk_container_add(
            GTK_CONTAINER(_topLeftFrame),
            _topLeftView.overlayWidget);
        gtk_widget_show(_topLeftView.overlayWidget);

        gtk_container_add(
            GTK_CONTAINER(_bottomRightFrame),
            _bottomRightView.overlayWidget);
        gtk_widget_show(_bottomRightView.overlayWidget);
    }];

    _topLeftView.nextResponder = self.contentView;
    _bottomRightView.nextResponder = self.contentView;
    self.dividerPosition = 0.5;
    return self;
}

- (GTKView *)topView
{
    return _topLeftView;
}

- (GTKView *)leftView
{
    return _topLeftView;
}

- (GTKView *)bottomView
{
    return _bottomRightView;
}

- (GTKView *)rightView
{
    return _bottomRightView;
}

- (GTKOrientation)orientation
{
    return _orientation;
}

- (void)setOrientation:(GTKOrientation)orientation
{
    _orientation = orientation;
    [GTKApp.dispatch.gtk sync: ^{
        gtk_orientable_set_orientation(
            GTK_ORIENTABLE(self.contentView.mainWidget),
            (GtkOrientation)(orientation));
    }];
    self.dividerPosition = self.dividerPosition;
}

- (double)dividerPosition
{
    return _handlePosition;
}

- (void)setDividerPosition:(double)position
{
    position = CLAMP(position, 0.0, 1.0);
    _handlePosition = position;
    double width = (double)(self.contentView.frame.width);
    double height = (double)(self.contentView.frame.height);
    double pos;
    if (self.orientation == GTKOrientationHorizontal) {
        pos = width * position;
    } else {
        pos = height * position;
    }
    gtk_paned_set_position(GTK_PANED(self.contentView.mainWidget), (int)(pos));
}
@end
