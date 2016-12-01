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

    GTKCoder *decoder = [GTKKeyedUnarchiver keyedUnarchiverWithXMLString: coder.XMLString];

    CodedClass *test = [GTKKeyedUnarchiver unarchiveObjectOfClass: CodedClass.class
                                                        withCoder: decoder];

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

    GTKKeyedArchiver *arrayCoder = [GTKKeyedArchiver archiveRootObject: array];

    GTKKeyedUnarchiver *arrayDecoder = [GTKKeyedUnarchiver keyedUnarchiverWithXMLString: arrayCoder.XMLString];

    OFArray *arrayTest = [GTKKeyedUnarchiver unarchiveObjectOfClass: OFArray.class
                                                          withCoder: arrayDecoder];

    CodedClass *dataTest = [arrayTest objectAtIndex: 0];

    if ([dataTest.stringValue isEqual: @"a1b2c3d4"] &&
         dataTest.doubleValue == 5.678901234 &&
         dataTest.floatValue == 3.456f &&
         dataTest.intValue == 5) {
        printf("Array test: Passed\n");
    }

    OFNumber *number = [OFNumber numberWithDouble: 2.345];

    GTKKeyedArchiver *numberCoder = [GTKKeyedArchiver archiveRootObject: number];

    GTKKeyedUnarchiver *numberDecoder = [GTKKeyedUnarchiver keyedUnarchiverWithXMLString: numberCoder.XMLString];

    OFNumber *numberTest = [GTKKeyedUnarchiver unarchiveObjectOfClass: OFNumber.class
                                                            withCoder: numberDecoder];
    if (numberTest.doubleValue == 2.345) {
        printf("OFNumber test: Passed\n");
    }

    OFDictionary *dict = [OFDictionary dictionaryWithObject: @"TestObject" forKey: @"TestKey"];

    GTKKeyedArchiver *dictCoder = [GTKKeyedArchiver archiveRootObject: dict];

    GTKKeyedUnarchiver *dictDecoder = [GTKKeyedUnarchiver keyedUnarchiverWithXMLString: dictCoder.XMLString];

    OFDictionary *dictTest = [GTKKeyedUnarchiver unarchiveObjectOfClass: OFDictionary.class
                                                              withCoder: dictDecoder];

    if ([[dictTest objectForKey: @"TestKey"] isEqual: @"TestObject"]) {
        printf("OFDictionary test: Passed\n");
    }

    OFNull *null = [OFNull null];

    GTKKeyedArchiver *nullCoder = [GTKKeyedArchiver archiveRootObject: null];

    GTKKeyedUnarchiver *nullDecoder = [GTKKeyedUnarchiver keyedUnarchiverWithXMLString: nullCoder.XMLString];

    OFNull *nullTest = [GTKKeyedUnarchiver unarchiveObjectOfClass: OFNull.class
                                                        withCoder: nullDecoder];
    if ([null isEqual: nullTest]) {
        printf("OFNull test: Passed\n");
    }

    OFURL *URL = [OFURL fileURLWithPath: @"/usr/local/bin/ls"];

    GTKKeyedArchiver *URLCoder = [GTKKeyedArchiver archiveRootObject: URL];

    GTKKeyedUnarchiver *URLDecoder = [GTKKeyedUnarchiver keyedUnarchiverWithXMLString: URLCoder.XMLString];

    OFURL *URLTest = [GTKKeyedUnarchiver unarchiveObjectOfClass: OFURL.class
                                                      withCoder: URLDecoder];
    if ([URL.path isEqual: URLTest.path]) {
        printf("OFURL test: Passed\n");
    }

    OFDate *date = [OFDate date];

    GTKKeyedArchiver *dateCoder = [GTKKeyedArchiver archiveRootObject: date];

    GTKKeyedUnarchiver *dateDecoder = [GTKKeyedUnarchiver keyedUnarchiverWithXMLString: dateCoder.XMLString];

    OFDate *dateTest = [GTKKeyedUnarchiver unarchiveObjectOfClass: OFDate.class
                                                        withCoder: dateDecoder];
    if (date.hour == dateTest.hour) {
        printf("OFDate test: Passed\n");
    }

    OFList *list = [OFList list];
    [list appendObject: @"abcdef987654321"];

    GTKKeyedArchiver *listCoder = [GTKKeyedArchiver archiveRootObject: list];

    GTKKeyedUnarchiver *listDecoder = [GTKKeyedUnarchiver keyedUnarchiverWithXMLString: listCoder.XMLString];

    OFList *listTest = [GTKKeyedUnarchiver unarchiveObjectOfClass: OFList.class
                                                        withCoder: listDecoder];

    if ([listTest.firstObject isEqual: @"abcdef987654321"]) {
        printf("OFList test: Passed\n");
    }

    GTKView *view = [GTKView new];

    view.layer = GTKViewLayerNotification;

    GTKKeyedArchiver *viewCoder = [GTKKeyedArchiver archiveRootObject: view];

    GTKKeyedUnarchiver *viewDecoder = [GTKKeyedUnarchiver keyedUnarchiverWithXMLString: viewCoder.XMLString];

    GTKView *viewTest = [GTKKeyedUnarchiver unarchiveObjectOfClass: GTKView.class
                                                         withCoder: viewDecoder];

    if (viewTest.layer == GTKViewLayerNotification) {
        printf("GTKView test: Passed\n");
    }

    [GTKApp terminate];
}

- (void)applicationWillTerminate
{

}
@end
