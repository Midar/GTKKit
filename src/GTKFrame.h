/*
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

#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKBin.h"

OF_ASSUME_NONNULL_BEGIN

/*!
 * @brief A container which draws a frame around its child, with an optional
 *	  label.
 */
@interface GTKFrame: GTKBin
/*!
 * The string to use as a label for the frame.
 *
 * @throws GTKDestroyedWidgetException
 */
@property OFString *label;

/*!
 * The custom widget to use as a label for the frame.
 *
 * Note that any GTKWidget can be used here, but the most common would be a
 * GTKImage.
 *
 * @throws GTKDestroyedWidgetException
 */
@property GTKWidget *labelWidget;

/*!
 * The horizontal alignment of the label.
 *
 * @throws GTKDestroyedWidgetException
 */
@property float labelHorizontalAlign;

/*!
 * The vertical alignment of the label.
 *
 * @throws GTKDestroyedWidgetException
 */
@property float labelVerticalAlign;
@end

OF_ASSUME_NONNULL_END
