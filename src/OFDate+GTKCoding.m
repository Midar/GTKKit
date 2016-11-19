/*! @file OFDate+GTKCoding.m
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

/*!
 * @brief An abstract parent class for classes which transfer data between
 * memory and other storage.
 */
@implementation OFDate (GTKCoding)
- (instancetype)initWithCoder:(GTKCoder *)decoder
{
    OFXMLElement *element = [decoder elementForName: @"GTKKit.coding.date"];
    OFDate *date = element.stringValue.objectByDeserializing;
    self = date;
    return self;
}

- (void)encodeWithCoder:(GTKCoder *)encoder
{
    OFXMLElement *element = [OFXMLElement elementWithName: @"GTKKit.coding.date"];
    element.stringValue = self.stringBySerializing;
    [encoder addChild: element];
}
@end
