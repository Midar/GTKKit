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

#import "GTKButton.h"
#import "GTKApplication.h"

const bool GTKOnState = true;
const bool GTKOffState = false;

static void
clicked_event_handler(GtkWidget *widget, GTKButton *button)
{
    [GTKApp.dispatch.main async: ^ {
        GTKEvent *evt = [GTKEvent new];
        evt.type = GTKEventTypeMouseClicked;
        evt.mouseButton = 1;
        evt.clicks = 1;
        [button mouseClicked: evt];
    }];
}

static gboolean
switch_activated_handler(GtkSwitch *widget, gboolean state, GTKButton *button)
{
    [GTKApp.dispatch.main async: ^ {
        GTKEvent *evt = [GTKEvent new];
        evt.type = GTKEventTypeMouseClicked;
        evt.mouseButton = 1;
        evt.clicks = 1;
        [button mouseClicked: evt];
        gtk_switch_set_state(widget, state);
    }];
    return true;
}

@implementation GTKButton
- init
{
    self = [super init];
    _buttonType = GTKPushButton;
    return self;
}

- (instancetype)initWithCoder:(GTKCoder *)decoder
{
	self = [super initWithCoder: decoder];
    OFString *type = [decoder decodeStringForKey: @"buttonType"];
    if ([type isEqual: @"push"]) {
        self.buttonType = GTKPushButton;
    } else if ([type isEqual: @"toggle"]) {
        self.buttonType = GTKToggleButton;
    } else if ([type isEqual: @"check"]) {
        self.buttonType = GTKCheckButton;
    } else if ([type isEqual: @"radio"]) {
        self.buttonType = GTKRadioButton;
    } else if ([type isEqual: @"switch"]) {
        self.buttonType = GTKSwitchButton;
    }
    self.state = [decoder decodeBoolForKey: @"state"];
    self.stringValue = [decoder decodeStringForKey: @"stringValue"];
    return self;
}

- (void)encodeWithCoder:(GTKCoder *)encoder
{
    [super encodeWithCoder: encoder];

    switch (self.buttonType) {
    case GTKPushButton:
        [encoder encodeString: @"push" forKey: @"buttonType"];
        break;
    case GTKToggleButton:
        [encoder encodeString: @"toggle" forKey: @"buttonType"];
        break;
    case GTKCheckButton:
        [encoder encodeString: @"check" forKey: @"buttonType"];
        break;
    case GTKRadioButton:
        [encoder encodeString: @"radio" forKey: @"buttonType"];
        break;
    case GTKSwitchButton:
        [encoder encodeString: @"switch" forKey: @"buttonType"];
        break;
    }
    [encoder encodeBool: self.state forKey: @"state"];
    [encoder encodeString: self.stringValue forKey: @"stringValue"];
}

- (void)dealloc
{
    [GTKApp.dispatch.gtk sync: ^{
        g_object_unref(G_OBJECT(_hiddenRadioButton));
    }];
}

- (void)createMainWidget
{
    [GTKApp.dispatch.gtk sync: ^{
        self.mainWidget = gtk_button_new();

        g_signal_connect(
            G_OBJECT(self.mainWidget),
            "clicked",
            G_CALLBACK(clicked_event_handler),
            (__bridge gpointer)(self));
        gtk_widget_set_focus_on_click (self.mainWidget,
                                       false);

        _imageWidget = gtk_image_new();
    }];
}

- (GTKButtonType)buttonType
{
    return _buttonType;
}

- (void)setButtonType:(GTKButtonType)buttonType
{
    _buttonType = buttonType;

    double alpha = self.alpha;
    OFString *stringValue = self.stringValue;
    bool state = self.state;

    [GTKApp.dispatch.gtk sync: ^{
        gtk_widget_destroy(self.mainWidget);
        g_object_unref(G_OBJECT(self.mainWidget));
        gtk_widget_destroy(_hiddenRadioButton);
        g_object_unref(G_OBJECT(_hiddenRadioButton));

        switch (_buttonType) {
        case GTKPushButton:
            self.mainWidget = gtk_button_new();
            break;
        case GTKToggleButton:
            self.mainWidget = gtk_toggle_button_new();
            break;
        case GTKCheckButton:
            self.mainWidget = gtk_check_button_new();
            break;
        case GTKRadioButton:
            _hiddenRadioButton = gtk_radio_button_new(NULL);
            self.mainWidget = gtk_radio_button_new_from_widget(GTK_RADIO_BUTTON(_hiddenRadioButton));
            g_object_ref_sink(G_OBJECT(_hiddenRadioButton));
            gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(self.mainWidget), GTKOffState);
            break;
        case GTKSwitchButton:
            self.mainWidget = gtk_switch_new();
            g_signal_connect(
                G_OBJECT(self.mainWidget),
                "state-set",
                G_CALLBACK(switch_activated_handler),
                (__bridge gpointer)(self));
            break;
        }

        g_object_ref_sink(G_OBJECT(self.mainWidget));
		gtk_container_add(GTK_CONTAINER(self.overlayWidget), self.mainWidget);

        if (_buttonType != GTKSwitchButton) {
            g_signal_connect(
                G_OBJECT(self.mainWidget),
                "clicked",
                G_CALLBACK(clicked_event_handler),
                (__bridge gpointer)(self));
        }

        gtk_widget_show(self.mainWidget);
        gtk_widget_set_focus_on_click (self.mainWidget,
                                       false);
    }];

    self.stringValue = stringValue;
    self.state = state;
    self.alpha = alpha;

    if (nil != _image) {
        gtk_button_set_image(GTK_BUTTON(self.mainWidget), _imageWidget);
        gtk_image_set_from_pixbuf(GTK_IMAGE(_imageWidget), _image.pixbuf);
    } else {
        gtk_image_clear(GTK_IMAGE(_imageWidget));
    }
    [self reconnectSignals];
}

- (OFString *)stringValue
{
    __block const char *str;
    [GTKApp.dispatch.gtk sync: ^{
        str = gtk_button_get_label(GTK_BUTTON(self.mainWidget));
    }];
    if (NULL == str) {
        str = "";
    }
    return [OFString stringWithUTF8String: str];
}

- (void)setStringValue:(OFString *)stringValue
{
    [GTKApp.dispatch.gtk sync: ^{
        gtk_button_set_label(GTK_BUTTON(self.mainWidget), stringValue.UTF8String);
    }];
}

- (void)mouseClicked:(nonnull GTKEvent*)event
{
    [GTKApp.dispatch.main sync: ^{
        [self sendActionToTarget];
        if (NULL != self.actionBlock) {
            self.actionBlock();
        }
        if (NULL != self.popOver) {
            self.popOver.hidden = false;
        }
    }];
}

- (bool)state
{
    __block bool state;
    [GTKApp.dispatch.gtk sync: ^{
        switch (_buttonType) {
        case GTKPushButton:
            state = false;
            break;
        case GTKToggleButton:
        case GTKCheckButton:
        case GTKRadioButton:
            state = gtk_toggle_button_get_active(GTK_TOGGLE_BUTTON(self.mainWidget));
            break;
        case GTKSwitchButton:
            state = gtk_switch_get_active(GTK_SWITCH(self.mainWidget));
            break;
        }
    }];
    return state;
}

- (void)setState:(bool)state
{
    [GTKApp.dispatch.gtk sync: ^{
        switch (_buttonType) {
        case GTKPushButton:
            break;
        case GTKToggleButton:
        case GTKCheckButton:
            gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(self.mainWidget), state);
            break;
        case GTKRadioButton:
            if (state == GTKOnState) {
                gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(self.mainWidget), GTKOnState);
            } else {
                gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(_hiddenRadioButton), GTKOnState);
            }
            break;
        case GTKSwitchButton:
            gtk_switch_set_active(GTK_SWITCH(self.mainWidget), state);
            break;
        }
    }];
}

- (GTKImage *)image
{
    return _image;
}

- (void)setImage:(GTKImage *)image
{
    _image = image;
    if (self.buttonType != GTKSwitchButton) {
        if (nil != _image) {
            if (NULL != _imageWidget) {
                gtk_widget_destroy(_imageWidget);
            }
            _imageWidget = gtk_image_new();
            g_object_ref(G_OBJECT(_imageWidget));
            gtk_button_set_image(GTK_BUTTON(self.mainWidget), _imageWidget);
            gtk_image_set_from_pixbuf(GTK_IMAGE(_imageWidget), _image.pixbuf);
        } else {
            gtk_image_clear(GTK_IMAGE(_imageWidget));
        }
    }
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
    [GTKApp.dispatch.gtk sync: ^{
        gtk_widget_grab_focus(self.mainWidget);
        if (gtk_widget_get_can_default(self.mainWidget)) {
            gtk_widget_grab_default(self.mainWidget);
        }
    }];
}

- (GTKPopOverViewController *)popOver
{
    return _popOver;
}

- (void)setPopOver:(GTKPopOverViewController *)popOver;
{
    _popOver = popOver;
    popOver.relativeView = self;
}
@end
