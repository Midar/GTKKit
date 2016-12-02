/*! @file GTKLinearView.m
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

#import "GTKLinearView.h"
#import "GTKApplication.h"
#import "OFArray+GTKCoding.h"
#import "GTKKeyedArchiver.h"
#import "GTKKeyedUnarchiver.h"

@implementation GTKLinearView
- init
{
    self = [super init];
    self.orientation = GTKOrientationVertical;
    return self;
}

- (void)createMainWidget
{
    [GTKApp.dispatch.gtk sync: ^{
        self.mainWidget = gtk_grid_new();
    }];
}

- (instancetype)initWithCoder:(GTKKeyedUnarchiver *)decoder
{
	self = [super initWithCoder: decoder];
    self.orientation = [[decoder decodeStringForKey: @"GTKKit.coding.linearView.orientation"] isEqual: @"horizontal"] ?
        GTKOrientationHorizontal : GTKOrientationVertical;
    return self;
}

- (void)encodeWithCoder:(GTKKeyedArchiver *)encoder
{
    [super encodeWithCoder: encoder];
    [encoder encodeString: self.orientation == GTKOrientationHorizontal ? @"horizontal" : @"vertical"
                   forKey: @"GTKKit.coding.linearView.orientation"];
}

- (void)addSubview:(GTKView *)view
{
    switch (view.layer) {
    case GTKViewLayerBackground:
    	if (![self.backgroundLayerSubviews containsObject: view]) {
    		[self.backgroundLayerSubviews addObject: view];
    	}
        break;
    case GTKViewLayerDefault:
    	if (![self.defaultLayerSubviews containsObject: view]) {
    		[self.defaultLayerSubviews addObject: view];
    	}
        break;
    case GTKViewLayerForeground:
    	if (![self.foregroundLayerSubviews containsObject: view]) {
    		[self.foregroundLayerSubviews addObject: view];
    	}
        break;
    case GTKViewLayerNotification:
    	if (![self.notificationLayerSubviews containsObject: view]) {
    		[self.notificationLayerSubviews addObject: view];
    	}
        break;
    }

    [view removeFromSuperview];
    view.superview = self;
    view.nextResponder = self;

    [GTKApp.dispatch.gtk sync: ^{
        gtk_container_add(
            GTK_CONTAINER(self.mainWidget),
            view.overlayWidget);
    }];

    [self layoutSubviews];
}

- (void)draw
{
    [super draw];

    for (GTKView *view in self.backgroundLayerSubviews) {
        __block GTKRect frame = [self layoutSubview: view];
        [GTKApp.dispatch.gtk sync: ^{
            gtk_widget_set_size_request(
                view.overlayWidget,
                frame.width, frame.height);
        }];
    }

    for (GTKView *view in self.defaultLayerSubviews) {
        __block GTKRect frame = [self layoutSubview: view];
        [GTKApp.dispatch.gtk sync: ^{
            gtk_widget_set_size_request(
                view.overlayWidget,
                frame.width, frame.height);
        }];
    }

    for (GTKView *view in self.foregroundLayerSubviews) {
        __block GTKRect frame = [self layoutSubview: view];
        [GTKApp.dispatch.gtk sync: ^{
            gtk_widget_set_size_request(
                view.overlayWidget,
                frame.width, frame.height);
        }];
    }

    for (GTKView *view in self.notificationLayerSubviews) {
        __block GTKRect frame = [self layoutSubview: view];
        [GTKApp.dispatch.gtk sync: ^{
            gtk_widget_set_size_request(
                view.overlayWidget,
                frame.width, frame.height);
        }];
    }
}


- (GTKRect)layoutSubview:(nonnull GTKView*)subview
{
    GTKRect frame = [super layoutSubview: subview];
    frame.x = 0;
    frame.y = 0;
    if (self.orientation == GTKOrientationVertical) {
        frame.width = self.frame.width;
    } else {
        frame.height = self.frame.height;
    }
    return frame;
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
            GTK_ORIENTABLE(self.mainWidget),
            (GtkOrientation)(orientation));
    }];
    for (GTKView *view in self.backgroundLayerSubviews) {
        [view removeFromSuperview];
        [self addSubview: view];
    }
    for (GTKView *view in self.defaultLayerSubviews) {
        [view removeFromSuperview];
        [self addSubview: view];
    }
    for (GTKView *view in self.foregroundLayerSubviews) {
        [view removeFromSuperview];
        [self addSubview: view];
    }
    for (GTKView *view in self.notificationLayerSubviews) {
        [view removeFromSuperview];
        [self addSubview: view];
    }
}
@end
