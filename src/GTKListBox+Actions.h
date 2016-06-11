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

#import "GTKListBox.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKListBox (Properties)
@property (readonly) int rowCount;
/*!
 * @brief Adds a widget to the list box at the beginning.
 *
 * @param childWidget The widget to add.
 */
- (void)prependWidget:(GTKWidget*)childWidget;
/*!
 * @brief Adds a widget to the list box at the end.
 *
 * @param childWidget The widget to add.
 */
- (void)appendWidget:(GTKWidget*)childWidget;
/*!
 * @brief Adds a widget to the list at the specified position.
 *
 * @param childWidget The widget to add.
 * @param position The position at which to place the widget.
 */
- (void)insertWidget:(GTKWidget*)childWidget
          atPosition:(int)position;
/*!
 * @brief Select the specified row.
 *
 * @param index The index of the row to select.
 */
- (void)selectRowAtIndex:(int)index;
/*!
 * @brief Unselect the specified row.
 *
 * @param index The index of the row to unselect.
 */
- (void)unselectRowAtIndex:(int)index;
/*!
 * @brief Select all rows.
 */
- (void)selectAll;
/*!
 * @brief Unselect all rows.
 */
- (void)unselectAll;
/*!
 * @brief Destroys the row at the specified index.
 *
 * @param index The index of the row to destroy.
 */
- (void)destroyRowAtIndex:(int)index;
/*!
 * @brief Gets the widget from the currently seleccted row.
 */
- (GTKWidget*)widgetForSelectedRow;
/*!
 * @brief Gets the widget for the specified row.
 *
 * @param index The index of the row for which to get the widget.
 */
- (GTKWidget*)widgetForRowAtIndex:(int)index;
@end

OF_ASSUME_NONNULL_END
