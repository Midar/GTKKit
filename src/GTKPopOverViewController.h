/*! @file GTKPopOverViewController.h
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
#import "enums.h"

@interface GTKPopOverViewController: GTKViewController
{
    __block GtkWidget *_popOver;
    __block __weak GTKView *_relativeView;
    __block GtkWidget *_relativeWidget;
    __block GTKPositionType _preferredPosition;
    __block int _width;
    __block int _height;
}
@property (getter=isHidden) bool hidden;
@property (weak) GTKView *relativeView;
@property GtkWidget *relativeWidget;
@property GTKPositionType preferredPosition;
@property int width;
@property int height;
@end
