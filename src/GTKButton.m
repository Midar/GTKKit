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
#import "GTKCallback.h"
#import "OFCallback.h"

static void
clicked_event_handler(GtkWidget *widget, gpointer userdata)
{
    GTKButton *button = (__bridge GTKButton *)(userdata);

    GTKEvent *evt = [GTKEvent new];
    evt.type = GTKEventTypeMouseClicked;
    evt.mouseButton = 1;

    [button mouseClicked: evt];
}

static gboolean
switch_activated_handler(GtkSwitch *widget, gboolean state, gpointer userdata)
{
    GTKButton *button = (__bridge GTKButton *)(userdata);

    gtk_switch_set_state(widget, state);

    GTKEvent *evt = [GTKEvent new];
    evt.type = GTKEventTypeMouseClicked;
    evt.mouseButton = 1;

    [button mouseClicked: evt];

    return true;
}

@implementation GTKButton
- init
{
    self = [super init];
    _buttonType = GTKPushButton;
    return self;
}

- (void)createMainWidget
{
    [GTKCallback sync: ^{
        self.mainWidget = gtk_button_new();
        g_object_ref_sink(G_OBJECT(self.mainWidget));

        _buttonClickedHandlerID = g_signal_connect(
            G_OBJECT(self.mainWidget),
            "clicked",
            G_CALLBACK(clicked_event_handler),
            (__bridge gpointer)(self));
    }];
}

- (GTKButtonType)buttonType
{
    return _buttonType;
}

- (void)setButtonType:(GTKButtonType)buttonType
{
    _buttonType = buttonType;

    [GTKCallback sync: ^{
        gtk_widget_destroy(self.mainWidget);
        gtk_widget_destroy(_hiddenRadioButton);

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
            gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(self.mainWidget), GTKOffState);
            break;
        case GTKSwitchButton:
            self.mainWidget = gtk_switch_new();
            _buttonClickedHandlerID = g_signal_connect(
                G_OBJECT(self.mainWidget),
                "state-set",
                G_CALLBACK(switch_activated_handler),
                (__bridge gpointer)(self));
            break;
        }

        g_object_ref_sink(G_OBJECT(self.mainWidget));
		gtk_container_add(GTK_CONTAINER(self.overlayWidget), self.mainWidget);

        if (_buttonType != GTKSwitchButton) {
            _buttonClickedHandlerID = g_signal_connect(
                G_OBJECT(self.mainWidget),
                "clicked",
                G_CALLBACK(clicked_event_handler),
                (__bridge gpointer)(self));
        }

        gtk_widget_show(self.mainWidget);

        gtk_button_set_always_show_image(GTK_BUTTON(self.mainWidget), true);
    }];
}

- (OFString *)stringValue
{
    __block OFString *stringValue;
    [GTKCallback sync: ^{
        const char *str = gtk_button_get_label(GTK_BUTTON(self.mainWidget));
        stringValue = [OFString stringWithUTF8String: str];
    }];
    return stringValue;
}

- (void)setStringValue:(OFString *)stringValue
{
    [GTKCallback sync: ^{
        gtk_button_set_label(GTK_BUTTON(self.mainWidget), stringValue.UTF8String);
    }];
}

- (void)mouseClicked:(nonnull GTKEvent*)event
{
    OFCallback(^{
        [self sendActionToTarget];
        if (NULL != self.actionBlock) {
            self.actionBlock();
        }
    });
}

- (bool)state
{
    __block bool state;
    [GTKCallback sync: ^{
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
    [GTKCallback sync: ^{
        switch (_buttonType) {
        case GTKPushButton:
            break;
        case GTKToggleButton:
        case GTKCheckButton:
        case GTKRadioButton:
            gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(self.mainWidget), state);
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
@end
