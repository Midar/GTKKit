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

#import "GTKLayoutConstraints.h"
#import "GTKKeyedArchiver.h"
#import "GTKKeyedUnarchiver.h"

@implementation GTKLayoutConstraint
+ (nullable instancetype)layoutConstraintWithType:(GTKLayoutConstraintType)type
											value:(double)value
{
	return [[self alloc] initWithType: type value: value];
}

- initWithType:(GTKLayoutConstraintType)type
		 value:(double)value
{
	self = [super init];
	self.type = type;
	self.value = value;
	return self;
}

- (nullable instancetype)init
{
	self = [super init];
	self.type = GTKLayoutConstraintTypeFixed;
	self.value = 0;
	return self;
}

- (instancetype)initWithCoder:(GTKKeyedUnarchiver *)decoder
{
	self = [self init];
	self.type = [[decoder decodeStringForKey: @"GTKKit.coding.layoutConstraint.type"] isEqual: @"fixed"] ?
		GTKLayoutConstraintTypeFixed : GTKLayoutConstraintTypeFlexible;
	self.value = [decoder decodeDoubleForKey: @"GTKKit.coding.layoutConstraint.value"];
	return self;
}

- (void)encodeWithCoder:(GTKKeyedArchiver *)encoder
{
	[encoder encodeString: self.type == GTKLayoutConstraintTypeFixed ? @"fixed" : @"flexible"
				   forKey: @"GTKKit.coding.layoutConstraint.type"];
	[encoder encodeDouble: self.value forKey: @"GTKKit.coding.layoutConstraint.value"];
}
@end

@implementation GTKLayoutConstraints
- init
{
	self = [super init];
  	self.width = [GTKLayoutConstraint layoutConstraintWithType: GTKLayoutConstraintTypeFlexible
														 value: 0];
  	self.height = [GTKLayoutConstraint layoutConstraintWithType: GTKLayoutConstraintTypeFlexible
														 value: 0];
  	self.top = [GTKLayoutConstraint new];
  	self.bottom = [GTKLayoutConstraint new];
  	self.left = [GTKLayoutConstraint new];
  	self.right = [GTKLayoutConstraint new];
	self.centerHorizontal = false;
	self.centerVertical = false;
  	return self;
}

- (instancetype)initWithCoder:(GTKKeyedUnarchiver *)decoder
{
	self = [self init];
	self.top = [decoder decodeObjectForKey: @"top"];
 	self.bottom = [decoder decodeObjectForKey: @"bottom"];
	self.left = [decoder decodeObjectForKey: @"left"];
	self.right = [decoder decodeObjectForKey: @"right"];
	self.width = [decoder decodeObjectForKey: @"width"];
   	self.height = [decoder decodeObjectForKey: @"height"];
	self.centerHorizontal = [decoder decodeBoolForKey: @"centerHorizontal"];
	self.centerVertical = [decoder decodeBoolForKey: @"centerVertical"];
	return self;
}

- (void)encodeWithCoder:(GTKKeyedArchiver *)encoder
{
	[encoder encodeObject: self.top
				   forKey: @"top"];
   	[encoder encodeObject: self.bottom
   				   forKey: @"bottom"];
   	[encoder encodeObject: self.left
   				   forKey: @"left"];
	[encoder encodeObject: self.right
				   forKey: @"right"];
   	[encoder encodeObject: self.width
   				   forKey: @"width"];
   	[encoder encodeObject: self.height
   				   forKey: @"height"];
   	[encoder encodeBool: self.centerHorizontal
   				   forKey: @"centerHorizontal"];
   	[encoder encodeBool: self.centerVertical
   				   forKey: @"centerVertical"];
}

- (void)fixedToTop:(double)top
			bottom:(double)bottom
			  left:(double)left
			 right:(double)right
{
	 self.top.type = GTKLayoutConstraintTypeFixed;
	 self.bottom.type = GTKLayoutConstraintTypeFixed;
	 self.left.type = GTKLayoutConstraintTypeFixed;
	 self.right.type = GTKLayoutConstraintTypeFixed;

	 self.top.value = top;
	 self.bottom.value = bottom;
	 self.left.value = left;
	 self.right.value = right;
}

- (void)fixedToTop:(double)top
			  left:(double)left
			 right:(double)right
{
	self.top.type = GTKLayoutConstraintTypeFixed;
	self.left.type = GTKLayoutConstraintTypeFixed;
	self.right.type = GTKLayoutConstraintTypeFixed;

	self.top.value = top;
	self.left.value = left;
	self.right.value = right;
}

- (void)fixedToTop:(double)top
			bottom:(double)bottom
			  left:(double)left
 {
	 self.top.type = GTKLayoutConstraintTypeFixed;
	 self.bottom.type = GTKLayoutConstraintTypeFixed;
	 self.left.type = GTKLayoutConstraintTypeFixed;

	 self.top.value = top;
	 self.bottom.value = bottom;
	 self.left.value = left;
 }

- (void)fixedToTop:(double)top
			bottom:(double)bottom
			 right:(double)right
{
	self.top.type = GTKLayoutConstraintTypeFixed;
	self.bottom.type = GTKLayoutConstraintTypeFixed;
	self.right.type = GTKLayoutConstraintTypeFixed;

	self.top.value = top;
	self.bottom.value = bottom;
	self.right.value = right;
}

- (void)fixedToBottom:(double)bottom
				 left:(double)left
				right:(double)right
{
	self.bottom.type = GTKLayoutConstraintTypeFixed;
	self.left.type = GTKLayoutConstraintTypeFixed;
	self.right.type = GTKLayoutConstraintTypeFixed;

	self.bottom.value = bottom;
	self.left.value = left;
	self.right.value = right;
}

- (void)fixedToTop:(double)top
			bottom:(double)bottom
{
	self.top.type = GTKLayoutConstraintTypeFixed;
	self.bottom.type = GTKLayoutConstraintTypeFixed;

	self.top.value = top;
	self.bottom.value = bottom;
}

- (void)fixedToTop:(double)top
			  left:(double)left
{
	self.top.type = GTKLayoutConstraintTypeFixed;
	self.left.type = GTKLayoutConstraintTypeFixed;

	self.top.value = top;
	self.left.value = left;
}

- (void)fixedToTop:(double)top
			 right:(double)right
{
	self.top.type = GTKLayoutConstraintTypeFixed;
	self.right.type = GTKLayoutConstraintTypeFixed;

	self.top.value = top;
	self.right.value = right;
}

- (void)fixedToBottom:(double)bottom
				 left:(double)left
{
	self.bottom.type = GTKLayoutConstraintTypeFixed;
	self.left.type = GTKLayoutConstraintTypeFixed;

	self.bottom.value = bottom;
	self.left.value = left;
}

- (void)fixedToBottom:(double)bottom
				right:(double)right
{
	self.bottom.type = GTKLayoutConstraintTypeFixed;
	self.right.type = GTKLayoutConstraintTypeFixed;

	self.bottom.value = bottom;
	self.right.value = right;
}

- (void)fixedToLeft:(double)left
			  right:(double)right
{
	self.left.type = GTKLayoutConstraintTypeFixed;
	self.right.type = GTKLayoutConstraintTypeFixed;

	self.left.value = left;
	self.right.value = right;
}

- (void)fixedToTop:(double)top
{
	self.top.type = GTKLayoutConstraintTypeFixed;
	self.top.value = top;
}

- (void)fixedToBottom:(double)bottom
{
	self.bottom.type = GTKLayoutConstraintTypeFixed;
	self.bottom.value = bottom;
}

- (void)fixedToLeft:(double)left
{
	self.left.type = GTKLayoutConstraintTypeFixed;
	self.left.value = left;
}

- (void)fixedToRight:(double)right
{
	self.right.type = GTKLayoutConstraintTypeFixed;
	self.right.value = right;
}

- (void)fixedWidth:(double)width
{
	self.width.type = GTKLayoutConstraintTypeFixed;
	self.width.value = width;
}

- (void)fixedHeight:(double)height
{
	self.height.type = GTKLayoutConstraintTypeFixed;
	self.height.value = height;
}

- (void)flexibleToTop:(double)top
			   bottom:(double)bottom
				 left:(double)left
				right:(double)right
{
	self.top.type = GTKLayoutConstraintTypeFlexible;
	self.bottom.type = GTKLayoutConstraintTypeFlexible;
	self.left.type = GTKLayoutConstraintTypeFlexible;
	self.right.type = GTKLayoutConstraintTypeFlexible;

	self.top.value = top;
	self.bottom.value = bottom;
	self.left.value = left;
	self.right.value = right;
}

- (void)flexibleToTop:(double)top
				 left:(double)left
				right:(double)right
{
	self.top.type = GTKLayoutConstraintTypeFlexible;
	self.left.type = GTKLayoutConstraintTypeFlexible;
	self.right.type = GTKLayoutConstraintTypeFlexible;

	self.top.value = top;
	self.left.value = left;
	self.right.value = right;
}

- (void)flexibleToTop:(double)top
			   bottom:(double)bottom
				 left:(double)left
{
	self.top.type = GTKLayoutConstraintTypeFlexible;
	self.bottom.type = GTKLayoutConstraintTypeFlexible;
	self.left.type = GTKLayoutConstraintTypeFlexible;

	self.top.value = top;
	self.bottom.value = bottom;
	self.left.value = left;
}

- (void)flexibleToTop:(double)top
			   bottom:(double)bottom
				right:(double)right
{
	self.top.type = GTKLayoutConstraintTypeFlexible;
	self.bottom.type = GTKLayoutConstraintTypeFlexible;
	self.right.type = GTKLayoutConstraintTypeFlexible;

	self.top.value = top;
	self.bottom.value = bottom;
	self.right.value = right;
}

- (void)flexibleToBottom:(double)bottom
					left:(double)left
				   right:(double)right
{
	self.bottom.type = GTKLayoutConstraintTypeFlexible;
	self.left.type = GTKLayoutConstraintTypeFlexible;
	self.right.type = GTKLayoutConstraintTypeFlexible;

	self.bottom.value = bottom;
	self.left.value = left;
	self.right.value = right;
}

- (void)flexibleToTop:(double)top
			   bottom:(double)bottom
{
	self.top.type = GTKLayoutConstraintTypeFlexible;
	self.bottom.type = GTKLayoutConstraintTypeFlexible;

	self.top.value = top;
	self.bottom.value = bottom;
}

- (void)flexibleToTop:(double)top
				 left:(double)left
{
	self.top.type = GTKLayoutConstraintTypeFlexible;
	self.left.type = GTKLayoutConstraintTypeFlexible;

	self.top.value = top;
	self.left.value = left;
}

- (void)flexibleToTop:(double)top
				right:(double)right
{
	self.top.type = GTKLayoutConstraintTypeFlexible;
	self.right.type = GTKLayoutConstraintTypeFlexible;

	self.top.value = top;
	self.right.value = right;
}

- (void)flexibleToBottom:(double)bottom
					left:(double)left
{
	self.bottom.type = GTKLayoutConstraintTypeFlexible;
	self.left.type = GTKLayoutConstraintTypeFlexible;

	self.bottom.value = bottom;
	self.left.value = left;
}

- (void)flexibleToBottom:(double)bottom
				   right:(double)right
{
	self.bottom.type = GTKLayoutConstraintTypeFlexible;
	self.right.type = GTKLayoutConstraintTypeFlexible;

	self.bottom.value = bottom;
	self.right.value = right;
}

- (void)flexibleToLeft:(double)left
				 right:(double)right
{
	self.left.type = GTKLayoutConstraintTypeFlexible;
	self.right.type = GTKLayoutConstraintTypeFlexible;

	self.left.value = left;
	self.right.value = right;
}

- (void)flexibleToTop:(double)top
{
	self.top.type = GTKLayoutConstraintTypeFlexible;
	self.top.value = top;
}

- (void)flexibleToBottom:(double)bottom
{
	self.bottom.type = GTKLayoutConstraintTypeFlexible;
	self.bottom.value = bottom;
}

- (void)flexibleToLeft:(double)left
{
	self.left.type = GTKLayoutConstraintTypeFlexible;
	self.left.value = left;
}

- (void)flexibleToRight:(double)right
{
	self.right.type = GTKLayoutConstraintTypeFlexible;
	self.right.value = right;
}

- (void)flexibleWidth:(double)width
{
	self.width.type = GTKLayoutConstraintTypeFlexible;
	self.width.value = width;
}

- (void)flexibleHeight:(double)height
{
	self.height.type = GTKLayoutConstraintTypeFlexible;
	self.height.value = height;
}
@end
