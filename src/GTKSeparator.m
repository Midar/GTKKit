/*! @file GTKSeparator.m
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

#import "GTKSeparator.h"
#import "GTKApplication.h"

@implementation GTKSeparator
- init
{
    self = [super init];
    _orientation = GTKOrientationHorizontal;
    return self;
}

- (void)createMainWidget
{
    [GTKApp.dispatch.gtk sync: ^{
        self.mainWidget = gtk_separator_new(GTK_ORIENTATION_HORIZONTAL);
    }];
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
