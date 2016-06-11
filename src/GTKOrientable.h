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

/*!
 * @brief A protocol for widgets that have an orientation property.
 */
@protocol GTKOrientable
/*!
 * @brief The widget's orientation.
 *
 * One of the following possible values:
 *
 * - GTK_ORIENTATION_HORIZONTAL
 * - GTK_ORIENTATION_VERTICAL
 */
@property GtkOrientation orientation;
@end
