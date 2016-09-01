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

#import "GTKContainer.h"
#import "GTKOrientable.h"

OF_ASSUME_NONNULL_BEGIN

/*!
 * @brief A container that organizes its children in a grid.
 */
@interface GTKGrid: GTKContainer <GTKOrientable>
/*!
 * Whether or not each column in the grid has the same width.
 *
 * @throws GTKDestroyedWidgetException
 */
@property bool columnsHomogeneous;

/*!
 * Whether or not each row in the grid has the same height.
 *
 * @throws GTKDestroyedWidgetException
 */
@property bool rowsHomogeneous;

/*!
 * The spacing between each row.
 *
 * @throws GTKDestroyedWidgetException
 */
@property unsigned int rowSpacing;

/*!
 * The spacing between each column.
 *
 * @throws GTKDestroyedWidgetException
 */
@property unsigned int columnsSpacing;

/*!
 * The row which determines the baseline of the grid.
 *
 * @throws GTKDestroyedWidgetException
 */
@property int baselineRow;

/*!
 * Gets the baseline position for the specified row.
 *
 * @throws GTKDestroyedWidgetException
 */
- (GtkBaselinePosition)baselinePositionForRow: (int)row;

/*!
 * Sets the baseline position for the specified row.
 *
 * @throws GTKDestroyedWidgetException
 */
- (void)setBaselinePosition: (GtkBaselinePosition)position
		     forRow: (int)row;
@end

OF_ASSUME_NONNULL_END
