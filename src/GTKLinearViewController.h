/*! @file GTKLinearViewController.h
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

#import "GTKViewController.h"
#import "GTKOrientable.h"
#import "GTKView.h"

/*!
 * @brief A class representing a view controller that lays its child views out
 * in either a single row or a single column.
 */
@interface GTKLinearViewController: GTKViewController <GTKOrientable>
{
    __block GTKOrientation _orientation;
    __block OFMutableArray<__kindof GTKView *> *_views;
}

- (void)addView:(nonnull GTKView *)view;
- (void)removeView:(nonnull GTKView *)view;
- (void)removeAllViews;
@end
