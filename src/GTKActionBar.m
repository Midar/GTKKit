/*! @file GTKActionBar.m
 *
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

#import "GTKActionBar.h"
#import "GTKApplication.h"

@implementation GTKActionBar
- init
{
    self = [super init];
    _actionSubviews = [OFMutableArray new];
    [self.constraints flexibleToTop: 0];
    [self.constraints fixedToBottom: 0
                               left: 0
                              right: 0];
    [self.constraints fixedHeight: 48];
    return self;
}

- (void)createMainWidget
{
    [GTKApp.dispatch.gtk sync: ^{
        self.mainWidget = gtk_action_bar_new();
    }];
}

- (GTKView *)centerView
{
    return _centerView;
}

- (void)setCenterView:(GTKView *)view
{
    if (self.centerView != nil) {
        [GTKApp.dispatch.gtk sync: ^{
            gtk_widget_unparent(self.centerView.overlayWidget);
        }];
        [_actionSubviews removeObject: self.centerView];
    }
    [_actionSubviews addObject: view];
    _centerView = view;
    [GTKApp.dispatch.gtk sync: ^{
        gtk_action_bar_set_center_widget(
            GTK_ACTION_BAR(self.mainWidget),
            self.centerView.overlayWidget);
    }];
}

- (void)addSubviewStart:(GTKView *)view
{
    [_actionSubviews addObject: view];
    [GTKApp.dispatch.gtk sync: ^{
        gtk_action_bar_pack_start(
            GTK_ACTION_BAR(self.mainWidget),
            view.overlayWidget);
    }];
}

- (void)addSubviewEnd:(GTKView *)view
{
    [_actionSubviews addObject: view];
    [GTKApp.dispatch.gtk sync: ^{
        gtk_action_bar_pack_end(
            GTK_ACTION_BAR(self.mainWidget),
            view.overlayWidget);
    }];
}
@end
