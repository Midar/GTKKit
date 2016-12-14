/*! @file GTKSlider.m
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

#import "GTKSlider.h"
#import "GTKApplication.h"
#import "GTKKeyedArchiver.h"
#import "GTKKeyedUnarchiver.h"

static void
value_changed_handler(GtkScale *scale, GTKSlider *slider)
{
	[GTKApp.dispatch.main async: ^ {
		[slider sendActionToTarget];
		if (NULL != slider.actionBlock) {
			slider.actionBlock();
		}
	}];
}

@implementation GTKSlider
- init
{
	self = [super init];
	_min = 0.0;
	_max = 100.0;
	[GTKApp.dispatch.gtk sync: ^{
		gtk_range_set_range(GTK_RANGE(self.mainWidget), _min, _max);
	}];
	self.showFillLevel = false;
	self.fillLevel = 0.0;
	self.doubleValue = 0.0;
	self.restrictToFillLevel = false;
	self.inverted = false;
	self.increment = 1.0;
	self.roundDigits = 0;
	self.highlightOrigin = false;
	self.showValue = false;
	return self;
}

- (instancetype)initWithCoder:(GTKKeyedUnarchiver *)decoder
{
	self = [super initWithCoder: decoder];
	self.minValue = [decoder decodeDoubleForKey: @"GTKKit.coding.slider.minValue"];
	self.maxValue = [decoder decodeDoubleForKey: @"GTKKit.coding.slider.maxValue"];
	self.restrictToFillLevel = [decoder decodeBoolForKey: @"GTKKit.coding.slider.restrictToFillLevel"];
	self.fillLevel = [decoder decodeDoubleForKey: @"GTKKit.coding.slider.fillLevel"];
	self.showFillLevel = [decoder decodeBoolForKey: @"GTKKit.coding.slider.showFillLevel"];
	self.inverted = [decoder decodeBoolForKey: @"GTKKit.coding.slider.inverted"];
	self.increment = [decoder decodeDoubleForKey: @"GTKKit.coding.slider.increment"];
	self.roundDigits = [decoder decodeIntForKey: @"GTKKit.coding.slider.roundDigits"];
	self.showValue = [decoder decodeBoolForKey: @"GTKKit.coding.slider.showValue"];
	OFString *valuePosition = [decoder decodeStringForKey: @"GTKKit.coding.slider.valuePosition"];
	if ([valuePosition isEqual: @"top"]) {
		self.valuePosition = GTKPositionTypeTop;
	} else if ([valuePosition isEqual: @"bottom"]) {
		self.valuePosition = GTKPositionTypeBottom;
	} else if ([valuePosition isEqual: @"left"]) {
		self.valuePosition = GTKPositionTypeLeft;
	} else if ([valuePosition isEqual: @"right"]) {
		self.valuePosition = GTKPositionTypeRight;
	}
	self.highlightOrigin = [decoder decodeBoolForKey: @"GTKKit.coding.slider.highlightOrigin"];
	self.numberOfTickMarks = [decoder decodeIntForKey: @"GTKKit.coding.slider.numberOfTickMarks"];
	self.orientation = [[decoder decodeStringForKey: @"GTKKit.coding.slider.orientation"] isEqual: @"horizontal"] ?
		GTKOrientationHorizontal : GTKOrientationVertical;
	return self;
}

- (void)encodeWithCoder:(GTKKeyedArchiver *)encoder
{
	[super encodeWithCoder: encoder];
	[encoder encodeDouble: self.minValue forKey: @"GTKKit.coding.slider.minValue"];
	[encoder encodeDouble: self.maxValue forKey: @"GTKKit.coding.slider.maxValue"];
	[encoder encodeBool: self.restrictToFillLevel forKey: @"GTKKit.coding.slider.restrictToFillLevel"];
	[encoder encodeDouble: self.fillLevel forKey: @"GTKKit.coding.slider.fillLevel"];
	[encoder encodeBool: self.showFillLevel forKey: @"GTKKit.coding.slider.showFillLevel"];
	[encoder encodeBool: self.isInverted forKey: @"GTKKit.coding.slider.inverted"];
	[encoder encodeDouble: self.increment forKey: @"GTKKit.coding.slider.increment"];
	[encoder encodeInt: self.roundDigits forKey: @"GTKKit.coding.slider.roundDigits"];
	[encoder encodeBool: self.showValue forKey: @"GTKKit.coding.slider.showValue"];
	switch (self.valuePosition) {
	case GTKPositionTypeTop:
		[encoder encodeString: @"top" forKey: @"valuePosition"];
		break;
	case GTKPositionTypeBottom:
		[encoder encodeString: @"bottom" forKey: @"valuePosition"];
		break;
	case GTKPositionTypeLeft:
		[encoder encodeString: @"left" forKey: @"valuePosition"];
		break;
	case GTKPositionTypeRight:
		[encoder encodeString: @"right" forKey: @"valuePosition"];
		break;
	}
	[encoder encodeBool: self.highlightOrigin forKey: @"GTKKit.coding.slider.highlightOrigin"];
	[encoder encodeInt: self.numberOfTickMarks forKey: @"GTKKit.coding.slider.numberOfTickMarks"];
	[encoder encodeString: self.orientation == GTKOrientationHorizontal ? @"horizontal" : @"vertical"
				   forKey: @"GTKKit.coding.slider.orientation"];
}

- (void)createMainWidget
{
	[GTKApp.dispatch.gtk sync: ^{
		self.mainWidget = gtk_scale_new(GTK_ORIENTATION_HORIZONTAL, NULL);
		_orientation = GTKOrientationHorizontal;
		g_signal_connect(
			G_OBJECT(self.mainWidget),
			"value-changed",
			G_CALLBACK(value_changed_handler),
			(__bridge gpointer)(self));
		gtk_range_set_flippable(GTK_RANGE(self.mainWidget), true);
	}];
}

- (GTKOrientation)orientation
{
	return _orientation;
}

- (void)setOrientation:(GTKOrientation)orientation
{
	if (orientation == _orientation) {
		return;
	}

	double fillLevel = self.fillLevel;
	double value = self.doubleValue;
	bool restrictToFillLevel = self.restrictToFillLevel;
	bool showFillLevel = self.showFillLevel;
	bool inverted = self.isInverted;
	double increment = self.increment;
	int roundDigits = self.roundDigits;
	bool highlightOrigin = self.highlightOrigin;
	bool showValue = self.showValue;

	[GTKApp.dispatch.gtk sync: ^{
		gtk_widget_destroy(self.mainWidget);
		_orientation = orientation;

		if (_orientation == GTKOrientationHorizontal) {
			self.mainWidget = gtk_scale_new(GTK_ORIENTATION_HORIZONTAL, NULL);
		} else {
			self.mainWidget = gtk_scale_new(GTK_ORIENTATION_VERTICAL, NULL);
		}

		gtk_range_set_range(GTK_RANGE(self.mainWidget), _min, _max);

		g_signal_connect(
			G_OBJECT(self.mainWidget),
			"value-changed",
			G_CALLBACK(value_changed_handler),
			(__bridge gpointer)(self));

		gtk_container_add(GTK_CONTAINER(self.overlayWidget), self.mainWidget);
		gtk_widget_show(self.mainWidget);
		gtk_range_set_flippable(GTK_RANGE(self.mainWidget), true);
	}];

	self.showValue = showValue;
	self.highlightOrigin = highlightOrigin;
	self.roundDigits = roundDigits;
	self.increment = increment;
	self.inverted = inverted;
	self.showFillLevel = showFillLevel;
	self.restrictToFillLevel = restrictToFillLevel;
	self.doubleValue = value;
	self.fillLevel = fillLevel;
}

- (double)minValue
{
	return _min;
}

- (void)setMinValue:(double)min
{
	_min = min;
	[GTKApp.dispatch.gtk sync: ^{
		gtk_range_set_range(GTK_RANGE(self.mainWidget), _min, _max);
	}];
}

- (double)maxValue
{
	return _max;
}

- (void)setMaxValue:(double)max
{
	_max = max;
	[GTKApp.dispatch.gtk sync: ^{
		gtk_range_set_range(GTK_RANGE(self.mainWidget), _min, _max);
	}];
}

- (double)doubleValue
{
	__block double doubleValue;
	[GTKApp.dispatch.gtk sync: ^{
		doubleValue = gtk_range_get_value(GTK_RANGE(self.mainWidget));
	}];
	return doubleValue;
}

- (void)setDoubleValue:(double)doubleValue
{
	[GTKApp.dispatch.gtk sync: ^{
		gtk_range_set_value(GTK_RANGE(self.mainWidget), doubleValue);
	}];
}

- (int)intValue
{
	__block double doubleValue;
	[GTKApp.dispatch.gtk sync: ^{
		doubleValue = gtk_range_get_value(GTK_RANGE(self.mainWidget));
	}];
	return (int)(ceil(doubleValue));
}

- (void)setIntValue:(int)intValue
{
	[GTKApp.dispatch.gtk sync: ^{
		gtk_range_set_value(GTK_RANGE(self.mainWidget), (double)(intValue));
	}];
}

- (float)floatValue
{
	__block double doubleValue;
	[GTKApp.dispatch.gtk sync: ^{
		doubleValue = gtk_range_get_value(GTK_RANGE(self.mainWidget));
	}];
	return (float)(doubleValue);
}

- (void)setFloatValue:(float)floatValue
{
	[GTKApp.dispatch.gtk sync: ^{
		gtk_range_set_value(GTK_RANGE(self.mainWidget), (double)(floatValue));
	}];
}

- (bool)restrictToFillLevel
{
	return _restrict;
}

- (void)setRestrictToFillLevel:(bool)restrictToFillLevel
{
	_restrict = restrictToFillLevel;
	[GTKApp.dispatch.gtk sync: ^{
		gtk_range_set_restrict_to_fill_level(GTK_RANGE(self.mainWidget), _restrict);
	}];
}

- (double)fillLevel
{
	return _fillLevel;
}

- (void)setFillLevel:(double)fillLevel
{
	_fillLevel = fillLevel;
	[GTKApp.dispatch.gtk sync: ^{
		gtk_range_set_fill_level(GTK_RANGE(self.mainWidget), _fillLevel);
	}];
}

- (bool)showFillLevel
{
	return _showFillLevel;
}

- (void)setShowFillLevel:(bool)showFillLevel
{
	_showFillLevel = showFillLevel;
	[GTKApp.dispatch.gtk sync: ^{
		gtk_range_set_show_fill_level(GTK_RANGE(self.mainWidget), _showFillLevel);
	}];
}

- (bool)isInverted
{
	return _inverted;
}

- (void)setInverted:(bool)inverted
{
	_inverted = inverted;
	[GTKApp.dispatch.gtk sync: ^{
		gtk_range_set_inverted(GTK_RANGE(self.mainWidget), _inverted);
	}];
}

- (double)increment
{
	return _increment;
}

- (void)setIncrement:(double)increment
{
	_increment = increment;
	[GTKApp.dispatch.gtk sync: ^{
		gtk_range_set_increments(GTK_RANGE(self.mainWidget), _increment, _increment);
	}];
}

- (int)roundDigits
{
	return _roundDigits;
}

- (void)setRoundDigits:(int)roundDigits
{
	_roundDigits = roundDigits;
	[GTKApp.dispatch.gtk sync: ^{
		gtk_scale_set_digits(GTK_SCALE(self.mainWidget), _roundDigits);
	}];
}

- (bool)showValue
{
	return _showValue;
}

- (void)setShowValue:(bool)showValue
{
	_showValue = showValue;
	[GTKApp.dispatch.gtk sync: ^{
		gtk_scale_set_draw_value(GTK_SCALE(self.mainWidget), _showValue);
	}];
}

- (GTKPositionType)valuePosition
{
	return _valuePosition;
}

- (void)setValuePosition:(GTKPositionType)valuePosition
{
	_valuePosition = valuePosition;
	[GTKApp.dispatch.gtk sync: ^{
		gtk_scale_set_value_pos(GTK_SCALE(self.mainWidget), (GtkPositionType)(_valuePosition));
	}];
}

- (bool)highlightOrigin
{
	return _highlightOrigin;
}

- (void)setHighlightOrigin:(bool)highlightOrigin
{
	_highlightOrigin = highlightOrigin;
	[GTKApp.dispatch.gtk sync: ^{
		gtk_scale_set_has_origin(GTK_SCALE(self.mainWidget), _highlightOrigin);
	}];
}

- (unsigned int)numberOfTickMarks
{
	return _numberOfTickMarks;
}

- (void)setNumberOfTickMarks:(unsigned int)numberOfTickMarks
{
	_numberOfTickMarks = numberOfTickMarks;
	int i = 0;
	gtk_scale_clear_marks(GTK_SCALE(self.mainWidget));
	if (_numberOfTickMarks == 0) {
		return;
	}
	if (_numberOfTickMarks == 1) {
		[GTKApp.dispatch.gtk sync: ^{
			double pos = (_max - _min) / 2;
			gtk_scale_add_mark(
				GTK_SCALE(self.mainWidget),
				pos,
				GTK_POS_TOP,
				NULL);
		}];
		return;
	}
	while (i <= numberOfTickMarks - 1) {
		[GTKApp.dispatch.gtk sync: ^{
			double pos = i * ((_max - _min) / (_numberOfTickMarks - 1));
			gtk_scale_add_mark(
				GTK_SCALE(self.mainWidget),
				pos,
				GTK_POS_TOP,
				NULL);
		}];
		i++;
	}
}
@end
