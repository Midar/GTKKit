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
#import "OFArray+GTKCoding.h"

#define REMOVE_OLD_VALUE_FOR_KEY                                               \
	OFArray *elements = [self.data elementsForName: key];                  \
	for (OFXMLElement *element in elements) {                              \
		[self.data removeChild: element];                              \
	}                                                                      \

@interface GTKKeyedArchiver (Private)
- (void)setClass: (Class)class
	  forKey: (OFString *)key;
@end

@implementation GTKKeyedArchiver
+ (instancetype)archiveRootObject: (id<GTKCoding>)object
{
	GTKKeyedArchiver *coder = [self new];
	[object encodeWithCoder: coder];
	return coder;
}

+ (void)archiveRootObject: (id<GTKCoding>)object
		    toURL: (OFURL *)url
{
	GTKKeyedArchiver *coder = [self archiveRootObject: object];
	[coder writeToURL: url];
}

- init
{
	self = [super init];
	return self;
}

- (void)writeToURL: (OFURL *)url
{
	of_comparison_result_t result = [url.scheme caseInsensitiveCompare: @"file"];
	if (result != 0) {
		return;
	}

	OFString *string = self.data.XMLString;

	[string writeToFile: url.path];
}

- (bool)allowsKeyedCoding
{
	return true;
}

- (void)encodeBool: (bool)value
	    forKey: (OFString *)key
{
	INVALID_KEY_EXCEPTION_CHECK
	REMOVE_OLD_VALUE_FOR_KEY

	OFString *string = value ? @"true" : @"false";
	OFXMLElement *element = [OFXMLElement elementWithName: key];
	element.stringValue = string;
	[self.data addChild: element];
}

- (void)encodeDouble: (double)value
	      forKey: (OFString *)key
{
	INVALID_KEY_EXCEPTION_CHECK
	REMOVE_OLD_VALUE_FOR_KEY

	OFNumber *number = [OFNumber numberWithDouble: value];
	OFXMLElement *element = [OFXMLElement elementWithName: key];
	element.stringValue = number.stringBySerializing;
	[self.data addChild: element];
}

- (void)encodeFloat: (float)value
	     forKey: (OFString *)key
{
	INVALID_KEY_EXCEPTION_CHECK
	REMOVE_OLD_VALUE_FOR_KEY

	OFNumber *number = [OFNumber numberWithFloat: value];
	OFXMLElement *element = [OFXMLElement elementWithName: key];
	element.stringValue = number.stringBySerializing;
	[self.data addChild: element];
}

- (void)encodeInt: (int)value
	   forKey: (OFString *)key
{
	INVALID_KEY_EXCEPTION_CHECK
	REMOVE_OLD_VALUE_FOR_KEY

	OFNumber *number = [OFNumber numberWithInt: value];
	OFXMLElement *element = [OFXMLElement elementWithName: key];
	element.stringValue = number.stringBySerializing;
	[self.data addChild: element];
}

- (void)encodeRect: (GTKRect)value
	    forKey: (OFString *)key
{
	OFNumber *x = [OFNumber numberWithInt: value.x];
	OFNumber *y = [OFNumber numberWithInt: value.y];
	OFNumber *width = [OFNumber numberWithInt: value.width];
	OFNumber *height = [OFNumber numberWithInt: value.height];
	OFArray *rect = @[x, y, width, height];

	GTKKeyedArchiver *coder = [GTKKeyedArchiver new];
	[rect encodeWithCoder: coder];
	coder.data.name = key;
	[self.data addChild: coder.XMLElementBySerializing];
}

- (void)encodeString: (OFString *)value
	      forKey: (OFString *)key
{
	INVALID_KEY_EXCEPTION_CHECK
	REMOVE_OLD_VALUE_FOR_KEY

	[self setClass: OFString.class forKey: key];
	OFXMLElement *element = [OFXMLElement elementWithName: key];
	element.stringValue = value;
	[self.data addChild: element];
}

- (void)encodeObject: (OFObject<GTKCoding> *)object
	      forKey: (OFString *)key
{
	INVALID_KEY_EXCEPTION_CHECK
	REMOVE_OLD_VALUE_FOR_KEY

	if ([object isKindOfClass: OFString.class]) {
		[self encodeString: (OFString *) object
		 	    forKey: key];
		return;
	}

	[self setClass: object.class
		forKey: key];
	GTKKeyedArchiver *coder = [GTKKeyedArchiver new];
	[object encodeWithCoder: coder];
	coder.data.name = key;
	[self.data addChild: coder.XMLElementBySerializing];
}

- (void)encodeSelector: (SEL)selector
		forKey: (OFString *)key
{
	INVALID_KEY_EXCEPTION_CHECK

	[self encodeString: OFStringFromSelector(selector)
		    forKey: key];
}
@end

@implementation GTKKeyedArchiver (Private)
- (void)setClass: (Class)class
	  forKey: (OFString *)key
{
	INVALID_KEY_EXCEPTION_CHECK

	OFString *className = [OFString stringWithUTF8String: class_getName(class.class)];

	OFXMLElement *classNames = [self.data elementForName: @"GTKKit.coding.classNames"];
	[classNames removeAttributeForName: key];
	[classNames addAttributeWithName: key
			     stringValue: className];
}
@end
