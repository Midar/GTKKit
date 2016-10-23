/*! @file GTKProgressIndicator.m
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

#import "GTKProgressIndicator.h"
#import "GTKApplication.h"

@implementation GTKProgressIndicator
- init
{
    self = [super init];
    self.showLabel = false;
    self.stringValue = @"";
    self.doubleValue = 0.0;
    return self;
}

- (void)createMainWidget
{
    [GTKApp.dispatch.gtk sync: ^{
        self.mainWidget = gtk_progress_bar_new();
        gtk_progress_bar_set_ellipsize(GTK_PROGRESS_BAR(self.mainWidget), PANGO_ELLIPSIZE_END);
        gtk_progress_bar_set_pulse_step(GTK_PROGRESS_BAR(self.mainWidget), 0.1);
    }];
}

- (bool)showLabel
{
    return _showLabel;
}

- (void)setShowLabel:(bool)showLabel
{
    _showLabel = showLabel;
    [GTKApp.dispatch.gtk sync: ^{
        gtk_progress_bar_set_show_text(GTK_PROGRESS_BAR(self.mainWidget), _showLabel);
    }];
}

- (bool)inverted
{
    return _inverted;
}

- (void)setInverted:(bool)inverted
{
    _inverted = inverted;
    [GTKApp.dispatch.gtk sync: ^{
        gtk_progress_bar_set_inverted(GTK_PROGRESS_BAR(self.mainWidget), _inverted);
    }];
}

- (OFString *)stringValue
{
    return _stringValue;
}

- (void)setStringValue:(OFString *)stringValue
{
    _stringValue = stringValue;
    [GTKApp.dispatch.gtk sync: ^{
        gtk_progress_bar_set_text(GTK_PROGRESS_BAR(self.mainWidget), _stringValue.UTF8String);
    }];
}

- (double)doubleValue
{
    return _doubleValue;
}

- (void)setDoubleValue:(double)doubleValue
{
    _doubleValue = doubleValue;
    [GTKApp.dispatch.gtk sync: ^{
        gtk_progress_bar_set_fraction(GTK_PROGRESS_BAR(self.mainWidget), _doubleValue);
    }];
}

- (int)intValue
{
    return (int)(ceil(self.doubleValue));
}

- (void)setIntValue:(int)intValue
{
    self.doubleValue = (double)(intValue);
}

- (float)floatValue
{
    return (float)(self.doubleValue);
}

- (void)setFloatValue:(float)floatValue
{
    self.doubleValue = (double)(floatValue);
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
}
@end
