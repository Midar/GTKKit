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
#import "GTKKeyedArchiver.h"
#import "GTKKeyedUnarchiver.h"

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
    self.buttonType = GTKPushButton;
    self.stringValue = @"";
    return self;
}

- (instancetype)initWithCoder:(GTKKeyedUnarchiver *)decoder
{
	self = [super initWithCoder: decoder];
    OFString *type = [decoder decodeStringForKey: @"GTKKit.coding.button.buttonType"];
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
    self.state = [decoder decodeBoolForKey: @"GTKKit.coding.button.state"];
    self.stringValue = [decoder decodeStringForKey: @"GTKKit.coding.button.stringValue"];
    return self;
}

- (void)encodeWithCoder:(GTKKeyedArchiver *)encoder
{
    [super encodeWithCoder: encoder];

    switch (self.buttonType) {
    case GTKPushButton:
        [encoder encodeString: @"push" forKey: @"GTKKit.coding.button.buttonType"];
        break;
    case GTKToggleButton:
        [encoder encodeString: @"toggle" forKey: @"GTKKit.coding.button.buttonType"];
        break;
    case GTKCheckButton:
        [encoder encodeString: @"check" forKey: @"GTKKit.coding.button.buttonType"];
        break;
    case GTKRadioButton:
        [encoder encodeString: @"radio" forKey: @"GTKKit.coding.button.buttonType"];
        break;
    case GTKSwitchButton:
        [encoder encodeString: @"switch" forKey: @"GTKKit.coding.button.buttonType"];
        break;
    }
    [encoder encodeBool: self.state forKey: @"GTKKit.coding.button.state"];
    [encoder encodeString: self.stringValue forKey: @"GTKKit.coding.button.stringValue"];
}

- (void)dealloc
{
    g_object_unref(_hiddenRadioButton);
    g_object_unref(_pushButton);
    g_object_unref(_toggleButton);
    g_object_unref(_checkButton);
    g_object_unref(_radioButton);
    g_object_unref(_switchButton);
    g_object_unref(_pushButtonImage);
    g_object_unref(_toggleButtonImage);
    g_object_unref(_checkButtonImage);
    g_object_unref(_radioButtonImage);
}

- (void)createMainWidget
{
    [GTKApp.dispatch.gtk sync: ^{
        self.mainWidget = gtk_grid_new();
        gtk_orientable_set_orientation(
            GTK_ORIENTABLE(self.mainWidget),
            GTK_ORIENTATION_VERTICAL);

        _pushButtonImage = gtk_image_new_from_icon_name("edit-delete", GTK_ICON_SIZE_MENU);
        gtk_image_clear(GTK_IMAGE(_pushButtonImage));
        g_object_ref_sink(_pushButtonImage);

        _toggleButtonImage = gtk_image_new_from_icon_name("edit-delete", GTK_ICON_SIZE_MENU);
        gtk_image_clear(GTK_IMAGE(_toggleButtonImage));
        g_object_ref_sink(_toggleButtonImage);

        _checkButtonImage = gtk_image_new_from_icon_name("edit-delete", GTK_ICON_SIZE_MENU);
        gtk_image_clear(GTK_IMAGE(_checkButtonImage));
        g_object_ref_sink(_checkButtonImage);

        _radioButtonImage = gtk_image_new_from_icon_name("edit-delete", GTK_ICON_SIZE_MENU);
        gtk_image_clear(GTK_IMAGE(_radioButtonImage));
        g_object_ref_sink(_radioButtonImage);

        _pushButton = gtk_button_new();
        g_object_ref_sink(_pushButton);
        g_signal_connect(
            G_OBJECT(_pushButton),
            "clicked",
            G_CALLBACK(clicked_event_handler),
            (__bridge gpointer)(self));
        gtk_widget_set_focus_on_click (
            _pushButton,
            false);
        gtk_widget_show(_pushButton);
        gtk_container_add(
            GTK_CONTAINER(self.mainWidget),
            _pushButton);
        gtk_widget_set_hexpand(_pushButton, true);
        gtk_widget_set_vexpand(_pushButton, true);
        gtk_button_set_image(
            GTK_BUTTON(_pushButton),
            _pushButtonImage);

        _toggleButton = gtk_toggle_button_new();
        g_object_ref_sink(_toggleButton);
        g_signal_connect(
            G_OBJECT(_toggleButton),
            "clicked",
            G_CALLBACK(clicked_event_handler),
            (__bridge gpointer)(self));
        gtk_widget_set_focus_on_click (
            _toggleButton,
            false);
        gtk_widget_hide(_toggleButton);
        gtk_container_add(
            GTK_CONTAINER(self.mainWidget),
            _toggleButton);
        gtk_widget_set_hexpand(_toggleButton, true);
        gtk_widget_set_vexpand(_toggleButton, true);
        gtk_button_set_image(
            GTK_BUTTON(_toggleButton),
            _toggleButtonImage);

        _checkButton = gtk_check_button_new();
        g_object_ref_sink(_checkButton);
        g_signal_connect(
            G_OBJECT(_checkButton),
            "clicked",
            G_CALLBACK(clicked_event_handler),
            (__bridge gpointer)(self));
        gtk_widget_set_focus_on_click (
            _checkButton,
            false);
        gtk_widget_hide(_checkButton);
        gtk_container_add(
            GTK_CONTAINER(self.mainWidget),
            _checkButton);
        gtk_widget_set_hexpand(_checkButton, true);
        gtk_widget_set_vexpand(_checkButton, true);
        gtk_button_set_image(
            GTK_BUTTON(_checkButton),
            _checkButtonImage);

        _hiddenRadioButton = gtk_radio_button_new(NULL);
        g_object_ref_sink(_hiddenRadioButton);
        g_signal_connect(
            G_OBJECT(_hiddenRadioButton),
            "clicked",
            G_CALLBACK(clicked_event_handler),
            (__bridge gpointer)(self));
        gtk_widget_set_focus_on_click (
            _hiddenRadioButton,
            false);

        _radioButton = gtk_radio_button_new_from_widget(GTK_RADIO_BUTTON(_hiddenRadioButton));
        g_object_ref_sink(_radioButton);
        g_signal_connect(
            G_OBJECT(_radioButton),
            "clicked",
            G_CALLBACK(clicked_event_handler),
            (__bridge gpointer)(self));
        gtk_widget_set_focus_on_click (
            _radioButton,
            false);
        gtk_widget_hide(_radioButton);
        gtk_container_add(
            GTK_CONTAINER(self.mainWidget),
            _radioButton);
        gtk_widget_set_hexpand(_radioButton, true);
        gtk_widget_set_vexpand(_radioButton, true);
        gtk_button_set_image(
            GTK_BUTTON(_radioButton),
            _radioButtonImage);

        _switchButton = gtk_switch_new();
        g_object_ref_sink(_switchButton);
        g_signal_connect(
            G_OBJECT(_switchButton),
            "state-set",
            G_CALLBACK(switch_activated_handler),
            (__bridge gpointer)(self));
        gtk_widget_set_focus_on_click (
            _switchButton,
            false);
        gtk_widget_hide(_switchButton);
        gtk_container_add(
            GTK_CONTAINER(self.mainWidget),
            _switchButton);
        gtk_widget_set_hexpand(_switchButton, true);
        gtk_widget_set_vexpand(_switchButton, true);
    }];
}

- (GTKButtonType)buttonType
{
    return _buttonType;
}

- (void)setButtonType:(GTKButtonType)buttonType
{
    _buttonType = buttonType;
    [GTKApp.dispatch.gtk sync: ^{
        gtk_widget_hide(_pushButton);
        gtk_widget_hide(_toggleButton);
        gtk_widget_hide(_checkButton);
        gtk_widget_hide(_radioButton);
        gtk_widget_hide(_switchButton);
        switch (buttonType) {
        case GTKPushButton:
            gtk_widget_show(_pushButton);
            break;
        case GTKToggleButton:
            gtk_widget_show(_toggleButton);
            break;
        case GTKCheckButton:
            gtk_widget_show(_checkButton);
            break;
        case GTKRadioButton:
            gtk_widget_show(_radioButton);
            break;
        case GTKSwitchButton:
            gtk_widget_show(_switchButton);
            break;
        }
    }];
}

- (OFString *)stringValue
{
    __block OFString *stringValue;
    [GTKApp.dispatch.gtk sync: ^{
        const char *str = gtk_button_get_label(GTK_BUTTON(_pushButton));
        stringValue = [OFString stringWithUTF8String: str];
    }];
    return stringValue;
}

- (void)setStringValue:(OFString *)stringValue
{
    [GTKApp.dispatch.gtk sync: ^{
        const char *str = NULL;
        if (![stringValue isEqual: @""]) {
            str = stringValue.UTF8String;
        }
        gtk_button_set_label(GTK_BUTTON(_pushButton), str);
        gtk_button_set_label(GTK_BUTTON(_toggleButton), str);
        gtk_button_set_label(GTK_BUTTON(_checkButton), str);
        gtk_button_set_label(GTK_BUTTON(_radioButton), str);
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
        state = gtk_toggle_button_get_active(GTK_TOGGLE_BUTTON(_toggleButton));
    }];
    return state;
}

- (void)setState:(bool)state
{
    [GTKApp.dispatch.gtk sync: ^{
        gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(_toggleButton), state);
        gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(_checkButton), state);
        gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(_hiddenRadioButton), !state);
        gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(_radioButton), state);
        gtk_switch_set_active(GTK_SWITCH(_switchButton), state);
    }];
}

- (GTKImage *)image
{
    return _image;
}

- (void)setImage:(GTKImage *)image
{
    _image = image;
    [GTKApp.dispatch.gtk sync: ^{
        gtk_image_set_from_pixbuf(
            GTK_IMAGE(_pushButtonImage),
            [image pixbufScaledToWidth: self.frame.width
                                height: self.frame.height
                     maintainingAspect: true]);
    }];
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

- (GTKPopover *)popOver
{
    return _popOver;
}

- (void)setPopOver:(GTKPopover *)popOver;
{
    _popOver = popOver;
    popOver.relativeView = self;
}
@end
