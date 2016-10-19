/*! @file GTKLevelIndicator.m
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

#import "GTKLevelIndicator.h"
#import "GTKCallback.h"

@implementation GTKLevelIndicator
- init
{
    self = [super init];
    _minValue = 0.0;
    _maxValue = 100.0;
    return self;
}

- (void)createMainWidget
{
    [GTKCallback sync: ^{
        self.mainWidget = gtk_level_bar_new();
    }];
}

- (double)minValue
{
    return _minValue;
}

- (void)setMinValue:(double)minValue
{
    _minValue = minValue;
    [GTKCallback sync: ^{
        gtk_level_bar_set_min_value(GTK_LEVEL_BAR(self.mainWidget), _minValue);
    }];
}

- (double)maxValue
{
    return _maxValue;
}

- (void)setMaxValue:(double)maxValue
{
    _maxValue = maxValue;
    [GTKCallback sync: ^{
        gtk_level_bar_set_max_value(GTK_LEVEL_BAR(self.mainWidget), _maxValue);
    }];
}

- (GTKLevelMode)mode
{
    return _mode;
}

- (void)setMode:(GTKLevelMode)mode
{
    _mode = mode;
    [GTKCallback sync: ^{
        gtk_level_bar_set_mode(GTK_LEVEL_BAR(self.mainWidget), (GtkLevelBarMode)(mode));
    }];
}

- (double)doubleValue
{
    __block double doubleValue;
    [GTKCallback sync: ^{
        doubleValue = gtk_level_bar_get_value(GTK_LEVEL_BAR(self.mainWidget));
    }];
    return doubleValue;
}

- (void)setDoubleValue:(double)doubleValue
{
    [GTKCallback sync: ^{
        gtk_level_bar_set_value(GTK_LEVEL_BAR(self.mainWidget), doubleValue);
    }];
}

- (float)floatValue
{
    return (float)(self.doubleValue);
}

- (void)setFloatValue:(float)floatValue
{
    self.doubleValue = (double)(floatValue);
}

- (int)intValue
{
    return (int)(ceil(self.doubleValue));
}

- (void)setIntValue:(int)intValue
{
    self.doubleValue = (double)(intValue);
}

- (bool)isInverted
{
    return _inverted;
}

- (void)setInverted:(bool)inverted
{
    _inverted = inverted;
    [GTKCallback sync: ^{
        gtk_level_bar_set_inverted(GTK_LEVEL_BAR(self.mainWidget), inverted);
    }];
}

- (GTKOrientation)orientation
{
    return _orientation;
}

- (void)setOrientation:(GTKOrientation)orientation
{
    _orientation = orientation;
    [GTKCallback sync: ^{
        gtk_orientable_set_orientation(
            GTK_ORIENTABLE(self.mainWidget),
            (GtkOrientation)(orientation));
    }];
}
@end
