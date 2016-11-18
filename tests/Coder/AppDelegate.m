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

#import "AppDelegate.h"
#import "CodedClass.h"

GTK_APPLICATION_DELEGATE(AppDelegate)

@implementation AppDelegate
- init
{
    self = [super init];
    // Put your custom initialization below this line.

    // It would be dangerous to modify anything below this line.

    return self;
}

- (void)applicationDidFinishLaunching
{
    // Put your custom post-launch startup code below this line.

    OFString *string = @"zyxabc";
    GTKCoder *stringCoder = [GTKKeyedArchiver archiveRootObject: string];

    OFString *stringTest = [GTKKeyedUnarchiver unarchiveObjectOfClass: OFString.class
                                                            withCoder: stringCoder];

    if ([stringTest isEqual: @"zyxabc"]) {
        printf("String test 1: Passed\n");
    }

    CodedClass *data = [CodedClass new];
    data.stringValue = @"abcdefghij1234567890";
    data.doubleValue = 0.123456789;
    data.floatValue = 1.2345f;
    data.intValue = 8;
    data.codedClassValue = [CodedClass new];
    data.codedClassValue.stringValue = @"0987654321jihgfedcba";
    data.codedClassValue.doubleValue = 9.87654321;
    data.codedClassValue.floatValue = 5.4321f;
    data.codedClassValue.intValue = 2;

    GTKCoder *coder = [GTKKeyedArchiver archiveRootObject: data];

    CodedClass *test = [GTKKeyedUnarchiver unarchiveObjectOfClass: CodedClass.class
                                                        withCoder: coder];

    if ([test.stringValue isEqual: @"abcdefghij1234567890"]) {
        printf("String test 2: Passed\n");
    }
    if (test.doubleValue == 0.123456789) {
        printf("Double test: Passed\n");
    }
    if (test.floatValue == 1.2345f) {
        printf("Float test: Passed\n");
    }
    if (test.intValue == 8) {
        printf("Int test: Passed\n");
    }
    if ([test.codedClassValue.stringValue isEqual: @"0987654321jihgfedcba"]) {
        printf("CodedClass property string test: Passed\n");
    }
    if (test.codedClassValue.doubleValue == 9.87654321) {
        printf("CodedClass property double test: Passed\n");
    }
    if (test.codedClassValue.floatValue == 5.4321f) {
        printf("CodedClass property float test: Passed\n");
    }
    if (test.codedClassValue.intValue == 2) {
        printf("CodedClass property int test: Passed\n");
    }

    CodedClass *data2 = [CodedClass new];
    data2.stringValue = @"a1b2c3d4";
    data2.doubleValue = 5.678901234;
    data2.floatValue = 3.456f;
    data2.intValue = 5;

    OFMutableArray *array = [OFMutableArray new];
    [array addObject: data2];

    GTKCoder *arrayCoder = [GTKKeyedArchiver archiveRootObject: array];

    OFArray *arrayTest = [GTKKeyedUnarchiver unarchiveObjectOfClass: OFArray.class
                                                          withCoder: arrayCoder];

    CodedClass *dataTest = [arrayTest objectAtIndex: 0];

    if ([dataTest.stringValue isEqual: @"a1b2c3d4"] &&
         dataTest.doubleValue == 5.678901234 &&
         dataTest.floatValue == 3.456f &&
         dataTest.intValue == 5) {
        printf("Array test: Passed\n");
    }

    OFNumber *number = [OFNumber numberWithDouble: 2.345];
    GTKCoder *numberCoder = [GTKKeyedArchiver archiveRootObject: number];
    OFNumber *numberTest = [GTKKeyedUnarchiver unarchiveObjectOfClass: OFNumber.class
                                                            withCoder: numberCoder];
    if (numberTest.doubleValue == 2.345) {
        printf("OFNumber test: Passed\n");
    }

    OFDictionary *dict = [OFDictionary dictionaryWithObject: @"TestObject" forKey: @"TestKey"];
    GTKCoder *dictCoder = [GTKKeyedArchiver archiveRootObject: dict];
    OFDictionary *dictTest = [GTKKeyedUnarchiver unarchiveObjectOfClass: OFDictionary.class
                                                              withCoder: dictCoder];

    if ([[dictTest objectForKey: @"TestKey"] isEqual: @"TestObject"]) {
        printf("OFDictionary test: Passed\n");
    }

    [GTKApp terminate];
}

- (void)applicationWillTerminate
{

}
@end
