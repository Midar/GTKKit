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

/*! @file GTKLinearView.h */

#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>

#import "GTKView.h"
#import "GTKOrientable.h"

OF_ASSUME_NONNULL_BEGIN

/*!
 * @brief A class representing a view that arranges its subviews in a single
 *	  row or a single column.
 */
@interface GTKLinearView: GTKView <GTKOrientable>
{
	GTKOrientation _orientation;
}
@end

OF_ASSUME_NONNULL_END
