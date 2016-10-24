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

@interface GTKSplitViewController: GTKViewController <GTKOrientable>
{
    GTKOrientation _orientation;
    GTKView *_topLeftView;
    GTKView *_bottomRightView;
    GtkWidget *_topLeftFrame;
    GtkWidget *_bottomRightFrame;
}
@property (readonly) GTKView *topView;
@property (readonly) GTKView *bottomView;
@property (readonly) GTKView *leftView;
@property (readonly) GTKView *rightView;
@end
