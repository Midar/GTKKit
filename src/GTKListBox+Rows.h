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
#import "GTKListBox+Actions.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKListBox (Rows)
/*!
 * @brief Whether or not the specified row is selected.
 *
 * @param index The row to check for selection.
 * @throws GTKDestroyedWidgetException
 * @throws GTKRowOutOfBoundsException
 */
- (bool)rowSelectedAtIndex: (int)index;

/*!
 * @brief Set the header for the specified row to the specified widget.
 *
 * @param index The row for which to set the header
 * @param header The widget to set as the header
 * @throws GTKDestroyedWidgetException
 * @throws GTKRowOutOfBoundsException
 */
- (void)setRowHeaderAtIndex: (int)index
		   toWidget: (GTKWidget)header;

/*!
 * @brief Whether or not the specified row is activatable.
 *
 * @param index The row to check.
 * @throws GTKDestroyedWidgetException
 * @throws GTKRowOutOfBoundsException
 */
- (bool)rowActivatableAtIndex: (int)index;

/*!
 * @brief Sets whether or not the specified row is activatable.
 *
 * @param index The row for which to set the activatable property
 * @param activatable Whether or not the row should be activatable.
 * @throws GTKDestroyedWidgetException
 * @throws GTKRowOutOfBoundsException
 */
- (void)setRowActivatableAtIndex: (int)index
			      to: (bool)activatable;

/*!
 * @brief Whether or not the specified row is selectable.
 *
 * @param index The row to check.
 * @throws GTKDestroyedWidgetException
 * @throws GTKRowOutOfBoundsException
 */
- (bool)rowSelectableAtIndex: (int)index;

/*!
* @brief Sets whether or not the specified row is selectable.
 *
 * @param index The row for which to set the activatable property
 * @param selectable Whether or not the row should be selectable.
 * @throws GTKDestroyedWidgetException
 * @throws GTKRowOutOfBoundsException
 */
- (void)setRowSelectableAtIndex: (int)index
			     to: (bool)selectable;

/*!
 * @brief Informs the list box that the specified row has changed.
 *
 * @param index The index of the changed row.
 * @throws GTKDestroyedWidgetException
 * @throws GTKRowOutOfBoundsException
 */
- (void)rowChangedAtIndex: (int)index;
@end

OF_ASSUME_NONNULL_END
