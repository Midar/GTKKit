/*! @file GTKPopOver.h
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

#import "GTKResponder.h"
#import "GTKPositionType.h"
#import "GTKView.h"

/*!
 * @brief A class representing a view controller that presents a view hierarchy
 * as a pop-up attached to another view.
 */
@interface GTKPopover: GTKResponder
{
    __block GtkWidget *_popOver;
    __block __weak GTKView *_relativeView;
    __block GtkWidget *_relativeWidget;
    __block GTKPositionType _preferredPosition;
    __block int _width;
    __block int _height;
}

/*!
 * @brief The GTKView that holds all this popover's subviews.
 */
@property (nullable) GTKView *contentView;

/*!
 * @brief Whether or not this pop-up is hidden.
 */
@property (getter=isHidden) bool hidden;

/*!
 * @brief The view relative to which this pop-up should be shown.
 */
@property (weak, nullable) GTKView *relativeView;

@property (nullable) GtkWidget *relativeWidget;

/*!
 * @brief The pop-up's preferred position relative to its relativeView. Depending
 * on the available screen-space, this may be ignored.
 */
@property GTKPositionType preferredPosition;

/*!
 * @brief The width of the pop-over.
 */
@property int width;

/*!
 * @brief The hieght of the pop-over.
 */
@property int height;
@end
