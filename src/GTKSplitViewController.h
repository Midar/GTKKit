/*! @file GTKSplitViewController.h
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

/*!
 * @brief A class representing a view controller that displays two view hierarchies
 * either side-by-side or one over the other, and allows the user to move the
 * boundary between them.
 */
@interface GTKSplitViewController: GTKViewController <GTKOrientable>
{
    __block GTKOrientation _orientation;
    __block GTKView *_topLeftView;
    __block GTKView *_bottomRightView;
    __block GtkWidget *_topLeftFrame;
    __block GtkWidget *_bottomRightFrame;
    __block double _handlePosition;
}

/*!
 * @brief The top view managed by this view controller. This is the same object
 * as the left view.
 */
@property (readonly) GTKView *topView;

/*!
 * @brief The bottom view managed by this view controller. This is the same object
 * as the right view.
 */
@property (readonly) GTKView *bottomView;

/*!
 * @brief The left view managed by this view controller. This is the same object
 * as the top view.
 */
@property (readonly) GTKView *leftView;

/*!
 * @brief The right view managed by this view controller. This is the same object
 * as the bottom view.
 */
@property (readonly) GTKView *rightView;

/*!
 * @brief The position of the divider between the two view hierarchies, with 0.0
 * being the left/top, and 1.0 being the bottom/right.
 */
@property double dividerPosition;
@end
