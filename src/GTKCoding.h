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

/*! @file GTKCoding.h */

#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>

OF_ASSUME_NONNULL_BEGIN

@class GTKKeyedArchiver;
@class GTKKeyedUnarchiver;

/*!
 * @brief A protocol for objects which serialize and deserialize themselves
 *	  using GTKCoder objects.
 */
@protocol GTKCoding <OFObject>
- (instancetype)initWithCoder: (GTKKeyedUnarchiver*)decoder;
- (void)encodeWithCoder: (GTKKeyedArchiver*)encoder;
@end

OF_ASSUME_NONNULL_END
