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

#import "CodedClass.h"

@implementation CodedClass
- (instancetype)initWithCoder:(GTKCoder *)decoder
{
    self = [self init];

    self.stringValue = [decoder decodeStringForKey: @"string"];
    self.doubleValue = [decoder decodeDoubleForKey: @"double"];
    self.floatValue = [decoder decodeFloatForKey: @"float"];
    self.intValue = [decoder decodeIntForKey: @"int"];
    self.codedClassValue = [decoder decodeObjectForKey: @"objectValue"];
    self.codedClassValue = [decoder decodeObjectForKey: @"codedClass"];

    return self;
}

- (void)encodeWithCoder:(GTKCoder *)encoder
{
    [encoder encodeString: self.stringValue forKey: @"string"];
    [encoder encodeDouble: self.doubleValue forKey: @"double"];
    [encoder encodeFloat: self.floatValue forKey: @"float"];
    [encoder encodeInt: self.intValue forKey: @"int"];
    [encoder encodeObject: self.objectValue forKey: @"objectValue"];
    [encoder encodeObject: self.codedClassValue forKey: @"codedClass"];
}
@end
