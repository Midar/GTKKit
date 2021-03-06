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

/*! @file GTKActionConnection.h */

#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>

#import "GTKCoder.h"

OF_ASSUME_NONNULL_BEGIN

/*!
 * @brief A class representing the connection between a serialized object and a
 * that objects target and action. This uses key-value coding.
 */
@interface GTKActionConnection: OFObject <GTKCoding>
@property (nullable) OFString *objectKeyPath;
@property (nullable) OFString *targetKeyPath;
@property (nullable) SEL actionSelector;
@end

OF_ASSUME_NONNULL_END
