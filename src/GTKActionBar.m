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
#import "OFArray+GTKCoding.h"
#import "GTKKeyedArchiver.h"
#import "GTKKeyedUnarchiver.h"

@implementation GTKActionBar
- init
{
    self = [super init];
    _actionSubviewsStart = [OFMutableArray new];
    _actionSubviewsEnd = [OFMutableArray new];
    [self.constraints flexibleToTop: 0];
    [self.constraints fixedToBottom: 0
                               left: 0
                              right: 0];
    [self.constraints fixedHeight: 48];
    return self;
}

- (instancetype)initWithCoder:(GTKKeyedUnarchiver *)decoder
{
	self = [super initWithCoder: decoder];

    self.centerView = [decoder decodeObjectForKey: @"GTKKit.coding.actionBar.centerView"];

    for (GTKView *view in [decoder decodeObjectForKey: @"GTKKit.coding.actionBar.actionSubviewsStart"]) {
        [self addSubviewStart: view];
    }

    for (GTKView *view in [decoder decodeObjectForKey: @"GTKKit.coding.actionBar.actionSubviewsEnd"]) {
        [self addSubviewEnd: view];
    }

    return self;
}

- (void)encodeWithCoder:(GTKKeyedArchiver *)encoder
{
    [super encodeWithCoder: encoder];

    [encoder encodeObject: self.centerView forKey: @"GTKKit.coding.actionBar.centerView"];
    [encoder encodeObject: _actionSubviewsStart forKey: @"GTKKit.coding.actionBar.actionSubviewsStart"];
    [encoder encodeObject: _actionSubviewsEnd forKey: @"GTKKit.coding.actionBar.actionSubviewsEnd"];
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
        //self.centerView = nil;
    }
    _centerView = view;
    [GTKApp.dispatch.gtk sync: ^{
        gtk_action_bar_set_center_widget(
            GTK_ACTION_BAR(self.mainWidget),
            self.centerView.overlayWidget);
    }];
}

- (void)addSubviewStart:(GTKView *)view
{
    [_actionSubviewsStart addObject: view];
    [GTKApp.dispatch.gtk sync: ^{
        gtk_action_bar_pack_start(
            GTK_ACTION_BAR(self.mainWidget),
            view.overlayWidget);
    }];
}

- (void)addSubviewEnd:(GTKView *)view
{
    [_actionSubviewsEnd addObject: view];
    [GTKApp.dispatch.gtk sync: ^{
        gtk_action_bar_pack_end(
            GTK_ACTION_BAR(self.mainWidget),
            view.overlayWidget);
    }];
}
@end
