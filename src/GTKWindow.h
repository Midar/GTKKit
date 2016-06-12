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
#import "GTKWindowDelegate.h"

OF_ASSUME_NONNULL_BEGIN

/*!
 * @brief A widget for toplevel windows.
 */
@interface GTKWindow: GTKBin
{
  of_dimension_t _defaultSize;
  of_dimension_t _size;
}
/*!
 * @brief The default size of the window.
 * @throws GTKDestroyedWidgetException
 */
@property of_dimension_t defaultSize;
/*!
 * @brief The actual size of the window.
 * @throws GTKDestroyedWidgetException
 */
@property of_dimension_t size;
/*!
 * @brief The delegate object for the window.
 * @throws GTKDestroyedWidgetException
 */
@property (nullable, weak)
    id <GTKWindowDelegate> delegate;
@end

OF_ASSUME_NONNULL_END
