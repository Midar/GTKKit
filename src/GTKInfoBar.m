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

- (void)dealloc
{
    [GTKApp.dispatch.gtk sync: ^{
        g_object_unref(G_OBJECT(_labelWidget));
    }];
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
