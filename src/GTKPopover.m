/*! @file GTKPopOver.m
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

#import "GTKPopover.h"
#import "GTKApplication.h"
#import "GTKKeyedArchiver.h"
#import "GTKKeyedUnarchiver.h"

@implementation GTKPopover
- init
{
    _width = 100;
    _height = 100;
    self = [super init];
    self.contentView = [GTKView new];
    [GTKApp.dispatch.gtk sync: ^{
        _popOver = gtk_popover_new(NULL);
        g_object_ref_sink(_popOver);
        gtk_widget_set_size_request(_popOver, _width, _height);
        gtk_popover_set_constrain_to(
            GTK_POPOVER(_popOver),
            GTK_POPOVER_CONSTRAINT_NONE);
        gtk_popover_set_modal(
            GTK_POPOVER(_popOver),
            true);
        gtk_container_add(
            GTK_CONTAINER(_popOver),
            self.contentView.overlayWidget);
    }];
    self.preferredPosition = GTKPositionTypeBottom;
    return self;
}

- (void)dealloc
{
    g_object_unref(_popOver);
}

- (instancetype)initWithCoder:(GTKKeyedUnarchiver *)decoder
{
	self = [self init];
    self.contentView = [decoder decodeObjectForKey: @"GTKKit.coding.popover.contentView"];
    self.hidden = [decoder decodeBoolForKey: @"GTKKit.coding.popover.hidden"];
    self.width = [decoder decodeIntForKey: @"GTKKit.coding.popover.width"];
    self.height = [decoder decodeIntForKey: @"GTKKit.coding.popover.height"];
    OFString *preferredPosition = [decoder decodeStringForKey: @"GTKKit.coding.popover.preferredPosition"];
    if ([preferredPosition isEqual: @"top"]) {
        self.preferredPosition = GTKPositionTypeTop;
    } else if ([preferredPosition isEqual: @"bottom"]) {
        self.preferredPosition = GTKPositionTypeBottom;
    } else if ([preferredPosition isEqual: @"left"]) {
        self.preferredPosition = GTKPositionTypeLeft;
    } else {
        self.preferredPosition = GTKPositionTypeRight;
    }
    return self;
}

- (void)encodeWithCoder:(GTKKeyedArchiver *)encoder
{
    [encoder encodeObject: self.contentView forKey: @"GTKKit.coding.popover.contentView"];
    [encoder encodeBool: self.isHidden forKey: @"GTKKit.coding.popover.hidden"];
    [encoder encodeInt: self.width forKey: @"GTKKit.coding.popover.width"];
    [encoder encodeInt: self.height forKey: @"GTKKit.coding.popover.height"];
    switch (self.preferredPosition) {
    case GTKPositionTypeTop:
        [encoder encodeString: @"top" forKey: @"GTKKit.coding.popover.preferredPosition"];
        break;
    case GTKPositionTypeBottom:
        [encoder encodeString: @"bottom" forKey: @"GTKKit.coding.popover.preferredPosition"];
        break;
    case GTKPositionTypeLeft:
        [encoder encodeString: @"left" forKey: @"GTKKit.coding.popover.preferredPosition"];
        break;
    case GTKPositionTypeRight:
        [encoder encodeString: @"right" forKey: @"GTKKit.coding.popover.preferredPosition"];
        break;
    }
}

- (bool)isHidden
{
    __block bool hidden;
    [GTKApp.dispatch.gtk sync: ^{
        hidden = !gtk_widget_get_visible(_popOver);
    }];
    return hidden;
}

- (void)setHidden:(bool)hidden
{
    [GTKApp.dispatch.gtk sync: ^{
        if (hidden) {
            gtk_popover_popdown(GTK_POPOVER(_popOver));
        } else {
            gtk_popover_popup(GTK_POPOVER(_popOver));
        }
    }];
}

- (GTKView *)relativeView
{
    return _relativeView;
}

- (void)setRelativeView:(GTKView *)view
{
    _relativeView = view;
    [GTKApp.dispatch.gtk sync: ^{
        gtk_popover_set_relative_to(
            GTK_POPOVER(_popOver),
            view.overlayWidget);
    }];
}

- (GtkWidget *)relativeWidget
{
    return _relativeWidget;
}

- (void)setRelativeWidget:(GtkWidget *)widget
{
    _relativeWidget = widget;
    [GTKApp.dispatch.gtk sync: ^{
        gtk_popover_set_relative_to(
            GTK_POPOVER(_popOver),
            _relativeWidget);
    }];
}

- (GTKPositionType)preferredPosition
{
    return _preferredPosition;
}

- (void)setPreferredPosition:(GTKPositionType)preferredPosition
{
    _preferredPosition = preferredPosition;
    [GTKApp.dispatch.gtk sync: ^{
        gtk_popover_set_position(
            GTK_POPOVER(_popOver),
            (GtkPositionType)(_preferredPosition));
    }];
}

- (int)width
{
    return _width;
}

- (void)setWidth:(int)width
{
    _width = width;
    [GTKApp.dispatch.gtk sync: ^{
        gtk_widget_set_size_request(_popOver, _width, _height);
    }];
}

- (int)height
{
    return _height;
}

- (void)setHeight:(int)height
{
    _height = height;
    [GTKApp.dispatch.gtk sync: ^{
        gtk_widget_set_size_request(_popOver, _width, _height);
    }];
}

- (id)copy
{
    GTKKeyedArchiver *coder = [GTKKeyedArchiver new];
    [coder encodeObject: self forKey: @"GTKKit.copying.GTKPopover"];
    GTKKeyedUnarchiver *decoder = [GTKKeyedUnarchiver keyedUnarchiverWithXMLString: coder.XMLString];
    return [decoder decodeObjectForKey: @"GTKKit.copying.GTKPopover"];
}
@end
