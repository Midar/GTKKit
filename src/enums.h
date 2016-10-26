/*! @file enums.h
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
 * @brief An enumeration of positions.
 */
typedef enum GTKPositionType {
    
    /*!
     * @brief The top position.
     */
    GTKPositionTypeTop = GTK_POS_TOP,

    /*!
     * @brief The bottom position.
     */
    GTKPositionTypeBottom = GTK_POS_BOTTOM,

    /*!
     * @brief The left position.
     */
    GTKPositionTypeLeft = GTK_POS_LEFT,

    /*!
     * @brief The right position.
     */
    GTKPositionTypeRight = GTK_POS_RIGHT
} GTKPositionType;
