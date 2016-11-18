/*! @file GTKKeyedArchiver.m
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

#import "GTKKeyedArchiver.h"

@implementation GTKKeyedArchiver
+ (instancetype)archiveRootObject:(id<GTKCoding>)object
{
    GTKKeyedArchiver *coder = [self new];
    [object encodeWithCoder: coder];
    return coder;
}

+ (void)archiveRootObject:(id<GTKCoding>)object
                    toURL:(OFURL *)url
{
    GTKKeyedArchiver *coder = [self archiveRootObject: object];
    [coder writeToURL: url];
}

- init
{
    self = [super init];
    return self;
}

- (void)writeToURL:(OFURL *)url
{
    of_comparison_result_t result = [url.scheme caseInsensitiveCompare: @"file"];
    if (result != 0) {
        return;
    }

    OFString *string = self.XMLString;

    [string writeToFile: url.path];
}

- (bool)allowsKeyedCoding
{
    return true;
}
@end
