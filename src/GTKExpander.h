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
 * @brief A class for object which represent containers that can hide their
 * child.
 */
@interface GTKExpander: GTKBin
/*!
 * @brief The label to use for the expander.
 * @throws GTKDestroyedWidgetException
 */
@property OFString *label;
/*!
 * @brief Whether or not the expander is expanded.
 * @throws GTKDestroyedWidgetException
 */
@property bool expanded;
/*!
 * @brief Whether or not the expander will resize its parent widget when it
 * expands or collapses.
 * @throws GTKDestroyedWidgetException
 */
@property bool resizeToplevel;
/*!
 * @brief Constructor to generate an expander with the specified label.
 *
 * @param label The string to use as a label.
 * @throws GTKDestroyedWidgetException
 */
+ (instancetype)expanderWithLabel:(OFString*)label;
/*!
 * @brief Initialize the expander with the specified label.
 *
 * @param label The string to use as a label.
 * @throws GTKDestroyedWidgetException
 */
- initWithLabel:(OFString *)label;
@end

OF_ASSUME_NONNULL_END
