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

#import "GTKWidget.h"

OF_ASSUME_NONNULL_BEGIN

/*!
 * @brief An abstract parent class for widgets which contain other widgets.
 */
@interface GTKContainer : GTKWidget
/*!
 * @brief The width of the border of the container.
 */
@property unsigned int borderWidth;
/*!
 * @brief Adds the specified widget to the container.
 *
 * @param childWidget The widget to add to the container.
 */
- (void)addWidget: (GTKWidget*)childWidget;
/*!
 * @brief Removes the specified widget from the container.
 *
 * @param childWidget The widget to remove from the container.
 */
- (void)removeWidget: (GTKWidget*)childWidget;
/*!
 * @brief Adds an array of widgets to the container.
 *
 * @param childWidgets The array of widgets to add to the container.
 */
- (void)addAll: (OFArray*)childWidgets;
@end

OF_ASSUME_NONNULL_END
