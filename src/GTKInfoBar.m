/*! @file GTKInfoBar.m
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


#import "GTKInfoBar.h"
#import "GTKApplication.h"
#import "OFArray+GTKCoding.h"
#import "GTKKeyedArchiver.h"
#import "GTKKeyedUnarchiver.h"

@interface GTKInfoBar ()
- (void)userResponded;
@end

static void
response_handler(GtkInfoBar *info_bar, int response_id, GTKInfoBar *infoBar)
{
	[GTKApp.dispatch.main async: ^{
		infoBar.response = (GTKResponseType)(response_id);
		[infoBar userResponded];
	}];
}

@implementation GTKInfoBar
- init
{
	self = [super init];
	[GTKApp.dispatch.gtk sync: ^{
		g_signal_connect(
			G_OBJECT(self.mainWidget),
			"response",
			G_CALLBACK(response_handler),
			(__bridge gpointer)(self));
	}];
	_buttonLabels = [OFMutableArray new];
	_buttonResponses = [OFMutableArray new];
	self.stringValue = @"";
	self.response = GTKResponseTypeNone;
	self.messageType = GTKMessageTypeInfo;
	[self.constraints fixedToTop: 0
							left: 0
						   right: 0];
   [self.constraints flexibleToBottom: 0];
   [self.constraints fixedHeight: 30];
	return self;
}

- (void)createMainWidget
{
	[GTKApp.dispatch.gtk sync: ^{
		self.mainWidget = gtk_info_bar_new();
		_labelWidget = gtk_label_new(NULL);
		g_object_ref_sink(G_OBJECT(_labelWidget));
		gtk_widget_show(_labelWidget);
		GtkWidget *contentArea = \
			gtk_info_bar_get_content_area(GTK_INFO_BAR(self.mainWidget));
		gtk_container_add(
			GTK_CONTAINER(contentArea),
			_labelWidget);
	}];
}

- (instancetype)initWithCoder:(GTKKeyedUnarchiver *)decoder
{
	self = [super initWithCoder: decoder];
	_buttonLabels = [decoder decodeObjectForKey: @"GTKKit.coding.infoBar.buttonLabels"];
	_buttonResponses = [decoder decodeObjectForKey: @"GTKKit.coding.infoBar.buttonResponses"];

	for (int i = 0; i < _buttonLabels.count; i++) {
		OFString *responseString = [_buttonResponses objectAtIndex: i];
		GTKResponseType response;
		if ([responseString isEqual: @"none"]) {
			response = GTKResponseTypeNone;
		} else if ([responseString isEqual: @"reject"]) {
			response = GTKResponseTypeReject;
		} else if ([responseString isEqual: @"accept"]) {
			response = GTKResponseTypeAccept;
		} else if ([responseString isEqual: @"delete"]) {
			response = GTKResponseTypeDelete;
		} else if ([responseString isEqual: @"ok"]) {
			response = GTKResponseTypeOK;
		} else if ([responseString isEqual: @"cancel"]) {
			response = GTKResponseTypeCancel;
		} else if ([responseString isEqual: @"close"]) {
			response = GTKResponseTypeClose;
		} else if ([responseString isEqual: @"yes"]) {
			response = GTKResponseTypeYes;
		} else if ([responseString isEqual: @"no"]) {
			response = GTKResponseTypeNo;
		} else if ([responseString isEqual: @"apply"]) {
			response = GTKResponseTypeApply;
		} else if ([responseString isEqual: @"help"]) {
			response = GTKResponseTypeHelp;
		} else {
			response = GTKResponseTypeNone;
		}
		[self addButtonWithLabel: [_buttonLabels objectAtIndex: i]
						response: response];
		self.stringValue = [decoder decodeStringForKey: @"GTKKit.coding.infoBar.stringValue"];
	}
	return self;
}

- (void)encodeWithCoder:(GTKKeyedArchiver *)encoder
{
	[super encodeWithCoder: encoder];
	[encoder encodeObject: _buttonLabels forKey: @"GTKKit.coding.infoBar.buttonLabels"];
	[encoder encodeObject: _buttonResponses forKey: @"GTKKit.coding.infoBar.buttonResponses"];
	[encoder encodeString: self.stringValue forKey: @"GTKKit.coding.infoBar.stringValue"];
}

- (void)dealloc
{
	g_object_unref(_labelWidget);
}

- (OFString *)stringValue
{
	return _label;
}

- (void)setStringValue:(OFString *)label
{
	_label = label;
	[GTKApp.dispatch.gtk sync: ^{
		gtk_label_set_markup(
			GTK_LABEL(_labelWidget),
			_label.UTF8String);
	}];
}

- (void)addButtonWithLabel:(OFString *)label response:(GTKResponseType)response
{
	[_buttonLabels addObject: label];
	OFString *responseString;
	switch (response) {
	case GTKResponseTypeNone:
		responseString = @"none";
		break;
	case GTKResponseTypeReject:
		responseString = @"reject";
		break;
	case GTKResponseTypeAccept:
		responseString = @"accept";
		break;
	case GTKResponseTypeDelete:
		responseString = @"delete";
		break;
	case GTKResponseTypeOK:
		responseString = @"ok";
		break;
	case GTKResponseTypeCancel:
		responseString = @"cancel";
		break;
	case GTKResponseTypeClose:
		responseString = @"close";
		break;
	case GTKResponseTypeYes:
		responseString = @"yes";
		break;
	case GTKResponseTypeNo:
		responseString = @"no";
		break;
	case GTKResponseTypeApply:
		responseString = @"apply";
		break;
	case GTKResponseTypeHelp:
		responseString = @"help";
		break;
	}
	[_buttonResponses addObject: responseString];
	[GTKApp.dispatch.gtk sync: ^{
		gtk_info_bar_add_button(
			GTK_INFO_BAR(self.mainWidget),
			label.UTF8String,
			(int)(response));
	}];
}

- (void)userResponded
{
	[GTKApp.dispatch.main sync: ^{
		[self sendActionToTarget];
		if (NULL != self.actionBlock) {
			self.actionBlock();
		}
	}];
}

- (GTKMessageType)messageType
{
	return _messageType;
}

- (void)setMessageType:(GTKMessageType)messageType
{
	_messageType = messageType;
	[GTKApp.dispatch.gtk sync: ^{
		gtk_info_bar_set_message_type(
			GTK_INFO_BAR(self.mainWidget),
			(GtkMessageType)(messageType));
	}];
}
@end
