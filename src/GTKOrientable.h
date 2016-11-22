/*! @file GTKOrientable.h
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

#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>

/*!
 * @brief The orientations available to orientable views.
 */
typedef enum GTKOrientation {

    /*!
     * @brief Horizontal orientation.
     */
    GTKOrientationHorizontal = GTK_ORIENTATION_HORIZONTAL,

    /*!
     * @brief Vertical orientation.
     */
    GTKOrientationVertical = GTK_ORIENTATION_VERTICAL
} GTKOrientation;


/*!
 * @brief A protocol for views which can be oriented.
 */
@protocol GTKOrientable

/*!
 * @brief The orientation of the view.
 */
@property GTKOrientation orientation;
@end
