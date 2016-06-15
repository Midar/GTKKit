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

#import "GTKGrid.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKGrid (Actions)
/*!
 * @brief Attaches a widget to the grid at the specified position.
 *
 * @param childWidget The widget to attach to the grid.
 * @param left The column the left side of the widget should occupy.
 * @param top The row the top of the widget should occupy.
 * @param width The number of columns the widget should span.
 * @param height The number of rows the widget should span.
 * @throws GTKDestroyedWidgetException
 */
- (void)attachWidget: (GTKWidget*)childWidget
                left: (int)left
                 top: (int)top
               width: (int)width
              height: (int)height;

/*!
 * @brief Attaches a widget to the grid next to the specified widget.
 *
 * @param childWidget The widget to attach to the grid.
 * @param siblingWidget The widget next to which the child widget should be
 * attached.
 * @param side The position of the sibling widget to which the child widget
 * should be attached.
 * @param width The number of columns the widget should span.
 * @param height The number of rows the widget should span.
 * @throws GTKDestroyedWidgetException
 */
- (void)attachWidget: (GTKWidget*)childWidget
            toWidget: (GTKWidget*)siblingWidget
              onSide: (GtkPositionType)side
               width: (int)width
              height: (int)height;

/*!
 * @brief Adds a row at the given position.
 * @throws GTKDestroyedWidgetException
 */
- (void)insertRowAtPosition: (int)position;

/*!
* @brief Adds a column at the given position.
* @throws GTKDestroyedWidgetException
*/
- (void)insertColumnAtPosition: (int)position;

/*!
* @brief Removes a row at the given position.
* @throws GTKDestroyedWidgetException
*/
- (void)removeRow: (int)position;

/*!
* @brief Removes a column at the given position.
* @throws GTKDestroyedWidgetException
*/
- (void)removeColumn: (int)position;
@end

OF_ASSUME_NONNULL_END
