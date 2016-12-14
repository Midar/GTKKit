/*! @file GTKTextField.m
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

#import "GTKTextField.h"
#import "GTKApplication.h"
#import "GTKKeyedArchiver.h"
#import "GTKKeyedUnarchiver.h"

static void
entry_activated_handler(GtkEntry *entry, GTKTextField *field)
{
	[GTKApp.dispatch.main async: ^ {
		[field sendActionToTarget];
		if (NULL != field.actionBlock) {
			field.actionBlock();
		}
	}];
}

static void
entry_insert_at_cursor_handler(GtkEntry *entry, GTKTextField *field)
{
	if (field.isContinuous) {
		[GTKApp.dispatch.main async: ^ {
			[field sendActionToTarget];
			if (NULL != field.actionBlock) {
				field.actionBlock();
			}
		}];
	}
}

static gboolean
text_view_focus_out_handler(GtkTextView *textView, GdkEvent *event, GTKTextField *field)
{
	[GTKApp.dispatch.main async: ^ {
		[field sendActionToTarget];
		if (NULL != field.actionBlock) {
			field.actionBlock();
		}
	}];
	return false;
}

@implementation GTKTextField
- (void)createMainWidget
{
	_editable = false;
	[GTKApp.dispatch.gtk sync: ^{
		self.mainWidget = gtk_grid_new();
		gtk_orientable_set_orientation(
			GTK_ORIENTABLE(self.mainWidget),
			GTK_ORIENTATION_VERTICAL);

		_labelWidget = gtk_label_new(NULL);
		g_object_ref_sink(_labelWidget);
		gtk_widget_hide(_labelWidget);
		gtk_container_add(
			GTK_CONTAINER(self.mainWidget),
			_labelWidget);
		gtk_widget_set_hexpand(_labelWidget, true);
		gtk_widget_set_vexpand(_labelWidget, true);


		_entryWidget = gtk_entry_new();
		g_object_ref_sink(_entryWidget);
		gtk_widget_hide(_entryWidget);
		gtk_container_add(
			GTK_CONTAINER(self.mainWidget),
			_entryWidget);
		gtk_widget_set_hexpand(_entryWidget, true);
		gtk_widget_set_vexpand(_entryWidget, true);

		g_signal_connect(
			G_OBJECT(_entryWidget),
			"activate",
			G_CALLBACK(entry_activated_handler),
			(__bridge gpointer)(self));
		g_signal_connect(
			G_OBJECT(_entryWidget),
			"insert-at-cursor",
			G_CALLBACK(entry_insert_at_cursor_handler),
			(__bridge gpointer)(self));

		_scrollWindow = gtk_scrolled_window_new(NULL, NULL);
		g_object_ref_sink(_scrollWindow);
		gtk_widget_hide(_scrollWindow);
		GtkStyleContext *context = gtk_widget_get_style_context(_scrollWindow);
		gtk_style_context_add_class(context, "gtkkit-textview");
		gtk_widget_set_hexpand(_scrollWindow, true);
		gtk_widget_set_vexpand(_scrollWindow, true);

		_textViewWidget = gtk_text_view_new();
		g_object_ref_sink(_textViewWidget);
		gtk_widget_show(_textViewWidget);
		gtk_widget_set_hexpand(_textViewWidget, true);
		gtk_widget_set_vexpand(_textViewWidget, true);

		gtk_container_add(
			GTK_CONTAINER(_scrollWindow),
			_textViewWidget);
		gtk_container_add(
			GTK_CONTAINER(self.mainWidget),
			_scrollWindow);

		g_signal_connect(
			G_OBJECT(_textViewWidget),
			"focus-out-event",
			G_CALLBACK(text_view_focus_out_handler),
			(__bridge gpointer)(self));

	}];
}

- init
{
	self = [super init];
	self.editable = false;
	self.multiline = false;
	self.selectable = false;
	self.justify = GTKJustificationCenter;
	self.continuous = false;
	return self;
}

- (void)dealloc
{
	g_object_unref(_textViewWidget);
	g_object_unref(_scrollWindow);
	g_object_unref(_entryWidget);
	g_object_unref(_labelWidget);
}

- (instancetype)initWithCoder:(GTKKeyedUnarchiver *)decoder
{
	self = [super initWithCoder: decoder];
	self.editable = [decoder decodeBoolForKey: @"GTKKit.coding.textField.editable"];
	self.continuous = [decoder decodeBoolForKey: @"GTKKit.coding.textField.continuous"];
	self.selectable = [decoder decodeBoolForKey: @"GTKKit.coding.textField.selectable"];
	OFString *justify = [decoder decodeStringForKey: @"GTKKit.coding.textField.justify"];
	if ([justify isEqual: @"left"]) {
		self.justify = GTKJustificationLeft;
	} else if ([justify isEqual: @"center"]) {
		self.justify = GTKJustificationCenter;
	} else if ([justify isEqual: @"right"]) {
		self.justify = GTKJustificationRight;
	} else if ([justify isEqual: @"fill"]) {
		self.justify = GTKJustificationFill;
	}
	self.multiline = [decoder decodeBoolForKey: @"GTKKit.coding.textField.multiline"];
	self.stringValue = [decoder decodeStringForKey: @"GTKKit.coding.textField.stringValue"];
	return self;
}

- (void)encodeWithCoder:(GTKKeyedArchiver *)encoder
{
	[super encodeWithCoder: encoder];
	[encoder encodeBool: self.isEditable forKey: @"GTKKit.coding.textField.editable"];
	[encoder encodeBool: self.isContinuous forKey: @"GTKKit.coding.textField.continuous"];
	[encoder encodeBool: self.isSelectable forKey: @"GTKKit.coding.textField.selectable"];
	switch (self.justify) {
	case GTKJustificationLeft:
		[encoder encodeString: @"left" forKey: @"GTKKit.coding.textField.justify"];
		break;
	case GTKJustificationCenter:
		[encoder encodeString: @"center" forKey: @"GTKKit.coding.textField.justify"];
		break;
	case GTKJustificationRight:
		[encoder encodeString: @"right" forKey: @"GTKKit.coding.textField.justify"];
		break;
	case GTKJustificationFill:
		[encoder encodeString: @"fill" forKey: @"GTKKit.coding.textField.justify"];
		break;
	}
	[encoder encodeBool: self.isMultiline forKey: @"GTKKit.coding.textField.multiline"];
	[encoder encodeString: self.stringValue forKey: @"GTKKit.coding.textField.stringValue"];
}

- (bool)isEditable
{
	return _editable;
}

- (void)setEditable:(bool)editable
{
	_editable = editable;
	self.stringValue = self.stringValue;
	[GTKApp.dispatch.gtk sync: ^{
		if (editable) {
			if (self.isMultiline) {
				gtk_widget_hide(_labelWidget);
				gtk_widget_hide(_entryWidget);
				gtk_widget_show(_scrollWindow);
			} else {
				gtk_widget_hide(_labelWidget);
				gtk_widget_show(_entryWidget);
				gtk_widget_hide(_scrollWindow);
			}
		} else {
			gtk_widget_show(_labelWidget);
			gtk_widget_hide(_entryWidget);
			gtk_widget_hide(_scrollWindow);
		}
	}];
}

- (OFString *)stringValue
{
	__block OFString *stringValue;
	__block const char *str;
	[GTKApp.dispatch.gtk sync: ^{
		str = gtk_entry_get_text(GTK_ENTRY(_entryWidget));
		stringValue = [OFString stringWithUTF8String: str];
	}];
	return stringValue;
}

- (void)setStringValue:(OFString *)stringValue
{
	[GTKApp.dispatch.gtk sync: ^{
		GtkTextBuffer *buf = gtk_text_view_get_buffer((GTK_TEXT_VIEW(_textViewWidget)));
		gtk_text_buffer_set_text(buf, stringValue.UTF8String, stringValue.length);
		gtk_entry_set_text(GTK_ENTRY(_entryWidget), stringValue.UTF8String);
		gtk_label_set_markup(GTK_LABEL(_labelWidget), stringValue.UTF8String);
	}];
}

- (bool)isSelectable
{
	return _selectable;
}

- (void)setSelectable:(bool)selectable
{
	_selectable = selectable;
	gtk_label_set_selectable(GTK_LABEL(_labelWidget), selectable);
}

- (bool)canBecomeFirstResponder
{
	return true;
}

- (bool)shouldBecomeFirstResponder
{
	return true;
}

- (void)didBecomeFirstResponder
{

}

- (GTKJustification)justify
{
	return _justify;
}

- (void)setJustify:(GTKJustification)justify
{
	_justify = justify;
	gtk_label_set_justify(GTK_LABEL(_labelWidget), (GtkJustification)(_justify));
}

- (bool)isMultiline
{
	return _multiline;
}

- (void)setMultiline:(bool)multiline
{
	_multiline = multiline;
	self.stringValue = self.stringValue;
	[GTKApp.dispatch.gtk sync: ^{
		if (self.isEditable) {
			if (multiline) {
				gtk_widget_hide(_labelWidget);
				gtk_widget_hide(_entryWidget);
				gtk_widget_show(_scrollWindow);
			} else {
				gtk_widget_hide(_labelWidget);
				gtk_widget_show(_entryWidget);
				gtk_widget_hide(_scrollWindow);
			}
		} else {
			gtk_widget_show(_labelWidget);
			gtk_widget_hide(_entryWidget);
			gtk_widget_hide(_scrollWindow);
		}
	}];
}
@end
