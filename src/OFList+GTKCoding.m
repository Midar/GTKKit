/*! @file OFList+GTKCoding.m
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

#import "OFArray+GTKCoding.h"
#import "GTKCoder.h"
#import "GTKKeyedArchiver.h"
#import "GTKKeyedUnarchiver.h"

/*!
 * @brief An abstract parent class for classes which transfer data between
 * memory and other storage.
 */
@implementation OFList (GTKCoding)
- (instancetype)initWithCoder:(GTKCoder *)decoder
{
    self = [self init];
    GTKCoder *coder = (GTKCoder *)[decoder elementForName: @"GTKKit.coding.list"];
    OFArray *array = [GTKKeyedUnarchiver unarchiveObjectOfClass: OFArray.class
                                                      withCoder: coder];
    for (id object in array) {
        [self appendObject: object];
    }
    return self;
}

- (void)encodeWithCoder:(GTKCoder *)encoder
{
    OFArray *array = self.objectEnumerator.allObjects;
    GTKCoder *coder = [GTKKeyedArchiver archiveRootObject: array];
    coder.name = @"GTKKit.coding.list";
    [encoder addChild: coder];
}
@end
