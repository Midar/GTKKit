/*! @file GTKKeyedUnarchiver.m
 *
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

#import "GTKKeyedUnarchiver.h"

/*!
 * @brief A class representing keyed archiver objects which have the ability to
 * write themselves to files.
 */
@implementation GTKKeyedUnarchiver
+ (instancetype)keyedUnarchiverWithContentsOfURL:(OFURL *)url
{
    OFString *string = [OFString stringWithContentsOfURL: url];

    return [[self alloc] initWithXMLString: string];
}

+ (id)unarchiveObjectOfClass:(Class)class
                   withCoder:(GTKCoder *)coder
{
    id object = [[class alloc] initWithCoder: coder];
    return object;
}

+ (id)unarchiveObjectOfClass:(Class)class
                     withURL:(OFURL *)url
{
    GTKKeyedUnarchiver *coder = [self keyedUnarchiverWithContentsOfURL: url];
    return [self unarchiveObjectOfClass: class
                              withCoder: coder];
}

- (bool)allowsKeyedCoding
{
    return true;
}
@end
