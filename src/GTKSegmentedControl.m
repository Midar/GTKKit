/*! @file GTKSegmentedControl.m
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

#import "GTKSegmentedControl.h"
#import "GTKApplication.h"
#import "GTKButton.h"
#import "OFArray+GTKCoding.h"
#import "GTKKeyedArchiver.h"
#import "GTKKeyedUnarchiver.h"

@interface GTKSegmentedControl ()
- (void)update;
@end

static gboolean
button_press_event_handler (GtkWidget           *widget,
			    GdkEvent            *event,
			    GTKSegmentedControl *control)
{
	control.selectedSegment = *(int*)(g_object_get_data(
	    G_OBJECT(widget),
	    "_GTKKIT_SEGMENTED_CONTROL_INDEX_"));
	[GTKApp.dispatch.main async: ^ {
		GTKEvent *evt = [GTKEvent new];
		evt.type = GTKEventTypeMouseClicked;
		evt.mouseButton = 1;
		[control mouseDown: evt];
	}];
	return false;
}

@implementation GTKSegmentedControl
- init
{
	self = [super init];

	_labelForSegment = [OFMutableArray arrayWithObjects:
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		nil
	];
	_imageForSegment = [OFMutableArray arrayWithObjects:
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		nil
	];
	_popOverForSegment = [OFMutableArray arrayWithObjects:
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		[OFNull null],
		nil
	];

	[GTKApp.dispatch.gtk sync: ^{
		gtk_widget_destroy(self.mainWidget);
		self.mainWidget = gtk_grid_new();
		g_object_ref_sink(G_OBJECT(self.mainWidget));
		gtk_grid_set_column_homogeneous(GTK_GRID(self.mainWidget), false);
		gtk_grid_set_column_spacing(GTK_GRID(self.mainWidget), 0);
		gtk_orientable_set_orientation(
		    GTK_ORIENTABLE(self.mainWidget),
		    GTK_ORIENTATION_HORIZONTAL);
		gtk_container_add(
		    GTK_CONTAINER(self.overlayWidget),
		    self.mainWidget);
		gtk_widget_show(self.mainWidget);
		GtkStyleContext *ctx = gtk_widget_get_style_context(self.mainWidget);
		gtk_style_context_add_class(ctx, "linked");

		int i = 0;
		while (i <= 31) {
			[_labelForSegment replaceObjectAtIndex: i withObject: [OFNull null]];
			_buttons[i] = gtk_button_new();
			_buttonIndex[i] = i;
			g_object_ref_sink(G_OBJECT(_buttons[i]));
			gtk_container_add(
			    GTK_CONTAINER(self.mainWidget),
			    _buttons[i]);
			gtk_widget_hide(_buttons[i]);
			g_signal_connect(
			    G_OBJECT(_buttons[i]),
			    "button-press-event",
			    G_CALLBACK(button_press_event_handler),
			    (__bridge gpointer)(self));
			g_object_set_data(
			    G_OBJECT(_buttons[i]),
			    "_GTKKIT_SEGMENTED_CONTROL_INDEX_",
			    &_buttonIndex[i]);
			i++;
		}
	}];
	self.segments = 1;
	self.trackingMode = GTKSegmentSwitchTrackingMomentary;
	return self;
}

- (instancetype)initWithCoder: (GTKKeyedUnarchiver *)decoder
{
	self = [super initWithCoder: decoder];

	OFString *trackingMode = [decoder decodeStringForKey: @"GTKKit.coding.segmentedControl.trackingMode"];
	if ([trackingMode isEqual: @"momentary"]) {
		self.trackingMode = GTKSegmentSwitchTrackingMomentary;
	} else if ([trackingMode isEqual: @"selectAny"]) {
		self.trackingMode = GTKSegmentSwitchTrackingSelectAny;
	} else if ([trackingMode isEqual: @"selectOne"]) {
		self.trackingMode = GTKSegmentSwitchTrackingSelectOne;
	}

	self.segments = [decoder decodeIntForKey: @"GTKKit.coding.segmentedControl.segments"];

	OFMutableArray *labels =  [decoder decodeObjectForKey: @"GTKKit.coding.segmentedControl.labelForSegment"];
	for (int i = 0; i < 32; i++) {
		[self setLabel: [labels objectAtIndex: i]
		    forSegment: i];
	}
	return self;
}

- (void)encodeWithCoder: (GTKKeyedArchiver *)encoder
{
	[super encodeWithCoder: encoder];

	switch (self.trackingMode) {
	case GTKSegmentSwitchTrackingMomentary:
		[encoder encodeString: @"momentary"
			       forKey: @"GTKKit.coding.segmentedControl.trackingMode"];
		break;
	case GTKSegmentSwitchTrackingSelectAny:
		[encoder encodeString: @"selectAny"
			       forKey: @"GTKKit.coding.segmentedControl.trackingMode"];
		break;
	case GTKSegmentSwitchTrackingSelectOne:
		[encoder encodeString: @"selectOne"
			       forKey: @"GTKKit.coding.segmentedControl.trackingMode"];
		break;
	}

	[encoder encodeInt: self.segments
		    forKey: @"GTKKit.coding.segmentedControl.segments"];

	[encoder encodeObject: _labelForSegment
		       forKey: @"GTKKit.coding.segmentedControl.labelForSegment"];
}

- (void)dealloc
{
	for (int i = 0; i < 32; i++) {
		g_object_unref(_buttons[i]);
	}
}

- (void)update
{
	[GTKApp.dispatch.gtk sync: ^{
		int i = 0;
		while (i < 32) {
			if (i <= self.segments-1) {
				gtk_widget_show(_buttons[i]);
			} else {
				gtk_widget_hide(_buttons[i]);
			}
			OFString *label = [self labelForSegment: i];
			[self setLabel: label forSegment: i];
			GTKImage *image = [self imageForSegment: i];
			[self setImage: image forSegment: i];
			GTKPopover *popOver = [self popOverForSegment: i];
			[self setPopOver: popOver forSegment: i];
			i++;
		}
		self.hidden = self.segments == 0;
	}];
}

- (int)segments
{
	return _segments;
}

- (void)setSegments: (int)segmentCount
{
	if (segmentCount > 32) {
		segmentCount = 32;
	}
	_segments = segmentCount;
	[self update];
}

- (void)mouseDown: (nonnull GTKEvent*)event
{
	[GTKApp.dispatch.main sync: ^{
		[self sendActionToTarget];
		if (NULL != self.actionBlock) {
			self.actionBlock();
		}
		GTKPopover *popOver = [self popOverForSegment: self.selectedSegment];
		if (NULL != popOver) {
			popOver.hidden = false;
		}
		if (!self.selectAny) {
			int i = 0;
			while (i <= 31) {
				if (i != self.selectedSegment) {
					[self setState: GTKOffState
					    forSegment: i];
				}
				i++;
			}
		}
	}];
}

- (void)setLabel: (OFString *)label
      forSegment: (int)segment
{
	if (segment >= 32) {
		segment = 31;
	}
	if (nil == label) {
		[_labelForSegment replaceObjectAtIndex: segment
					    withObject: [OFNull null]];
	   gtk_button_set_label(
		   GTK_BUTTON(_buttons[segment]),
		   NULL);
	} else {
		[_labelForSegment replaceObjectAtIndex: segment
					    withObject: label];
		gtk_button_set_label(
		    GTK_BUTTON(_buttons[segment]),
		    label.UTF8String);
	}
}

- (OFString *)labelForSegment: (int)segment
{
	if (segment >= 32) {
		segment = 31;
	}
	OFString *label = [_labelForSegment objectAtIndex: segment];
	if ((id)(label) == [OFNull null]) {
		return nil;
	} else {
		return (OFString *)(label);
	}
}

- (void)setImage: (GTKImage *)image
      forSegment: (int)segment
{
	if (segment >= 32) {
		segment = 31;
	}
	[GTKApp.dispatch.gtk sync: ^{
		GtkWidget *_imageWidget;
		if (nil == image) {
			[_imageForSegment replaceObjectAtIndex: segment
						    withObject: [OFNull null]];
			_imageWidget = gtk_button_get_image(GTK_BUTTON(_buttons[segment]));
			if (_imageWidget != NULL) {
				gtk_container_remove(GTK_CONTAINER(_buttons[segment]), _imageWidget);
				gtk_widget_destroy(_imageWidget);
			}
		} else {
			_imageWidget = gtk_button_get_image(GTK_BUTTON(_buttons[segment]));
			if (_imageWidget != NULL) {
				gtk_container_remove(GTK_CONTAINER(_buttons[segment]), _imageWidget);
				gtk_widget_destroy(_imageWidget);
			}
			_imageWidget = gtk_image_new();
			gtk_image_set_from_pixbuf(GTK_IMAGE(_imageWidget), image.pixbuf);
			gtk_button_set_image(GTK_BUTTON(_buttons[segment]), _imageWidget);
		}
	}];
}

- (GTKImage *)imageForSegment: (int)segment
{
	if (segment >= 32) {
		segment = 31;
	}
	GTKImage *image = [_imageForSegment objectAtIndex: segment];
	if ((id)(image) == [OFNull null]) {
		return nil;
	} else {
		return (GTKImage *)(image);
	}
}

- (void)setPopOver: (GTKPopover *)popOver
	forSegment: (int)segment
{
	if (segment >= 32) {
		segment = 31;
	}
	if (nil == popOver) {
		[_popOverForSegment replaceObjectAtIndex: segment
					      withObject: [OFNull null]];
	   popOver.relativeWidget = nil;
	} else {
		[_popOverForSegment replaceObjectAtIndex: segment
					      withObject: popOver];
		popOver.relativeWidget = _buttons[segment];
	}
}

- (GTKPopover *)popOverForSegment: (int)segment
{
	if (segment >= 32) {
		segment = 31;
	}
	GTKPopover *popOver = [_popOverForSegment objectAtIndex: segment];
	if ((id)(popOver) == [OFNull null]) {
		return nil;
	} else {
		return (GTKPopover *)(popOver);
	}
}

- (bool)isMomentary
{
	return _momentary;
}

- (void)setMomentary: (bool)momentary
{
	if (_momentary == momentary) {
		return;
	}
	_momentary = momentary;
	[GTKApp.dispatch.gtk sync: ^{
		int i = 0;
		while (i <= 31) {
			gtk_widget_destroy(_buttons[i]);
			i++;
		}
		if (_momentary) {
			i = 0;
			while (i <= 31) {
				_buttons[i] = gtk_button_new();
				_buttonIndex[i] = i;
				i++;
			}
		} else {
			i = 0;
			while (i <= 31) {
				_buttons[i] = gtk_toggle_button_new();
				_buttonIndex[i] = i;
				i++;
			}
		}
		i = 0;
		while (i <= 31) {
			g_object_ref_sink(G_OBJECT(_buttons[i]));
			gtk_container_add(
			    GTK_CONTAINER(self.mainWidget),
			    _buttons[i]);
			gtk_widget_hide(_buttons[i]);
			g_signal_connect(
			    G_OBJECT(_buttons[i]),
			    "button-press-event",
			    G_CALLBACK(button_press_event_handler),
			    (__bridge gpointer)(self));
			g_object_set_data(
			    G_OBJECT(_buttons[i]),
			    "_GTKKIT_SEGMENTED_CONTROL_INDEX_",
			    &_buttonIndex[i]);
			i++;
		}
	}];
	[self update];
}

- (bool)stateForSegment: (int)segment
{
	if (self.isMomentary) {
		return GTKOffState;
	}
	__block bool state;
	[GTKApp.dispatch.gtk sync: ^{
		state = gtk_toggle_button_get_active(GTK_TOGGLE_BUTTON(_buttons[segment]));
	}];
	return state;
}

- (void)setState: (bool)state
      forSegment: (int)segment
{
	if (self.isMomentary) {
		return;
	}
	[GTKApp.dispatch.gtk sync: ^{
		gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(_buttons[segment]), state);
	}];
}

- (GTKSegmentSwitchTracking)trackingMode
{
	return _trackingMode;
}

- (void)setTrackingMode: (GTKSegmentSwitchTracking)trackingMode
{
	if (_trackingMode == trackingMode) {
		return;
	}
	_trackingMode = trackingMode;
	switch (_trackingMode) {
	case GTKSegmentSwitchTrackingSelectOne:
		self.momentary = false;
		self.selectAny = false;
		break;
	case GTKSegmentSwitchTrackingSelectAny:
		self.momentary = false;
		self.selectAny = true;
		break;
	case GTKSegmentSwitchTrackingMomentary:
		self.momentary = true;
		self.selectAny = true;
		break;
	}
}
@end
