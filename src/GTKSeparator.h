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
#import "GTKOrientable.h"

OF_ASSUME_NONNULL_BEGIN

/*!
 * @brief A class for widgets which separate other widgets.
 */
@interface GTKSeparator: GTKWidget <GTKOrientable>
/*!
 * @brief Initialize the separator with the specified orientation.
 */
+ (instancetype)separatorWithOrientation:(GtkOrientation)orientation;

/*!
 * @brief Create a new separator with the specified orientation.
 */
- initWithOrientation:(GtkOrientation)orientation;
@end

OF_ASSUME_NONNULL_END
