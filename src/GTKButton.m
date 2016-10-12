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
    printf("1\n");
    GTKButton *button = (__bridge GTKButton *)(userdata);

    printf("2\n");
    GTKEvent *evt = [GTKEvent new];
    printf("3\n");
    evt.type = GTKEventTypeMouseClicked;
    printf("4\n");
    evt.mouseButton = 1;
    printf("5\n");

   [button mouseClicked: evt];
       printf("6\n");
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

        //self.childPositionHandlerID = g_signal_connect(
        //    G_OBJECT(self.mainWidget),
        //    "clicked",
        //    G_CALLBACK(clicked_event_handler),
        //    (__bridge gpointer)(self));
    }];
}

- (GTKButtonType)buttonType
{
    return _buttonType;
}

- (void)setButtonType:(GTKButtonType)buttonType
{
    _buttonType = buttonType;
    //FIXME: Change the type of the button widget used.
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
    });
}

- (void)mouseUp:(nonnull GTKEvent*)event
{
    OFCallback(^{
        [self sendActionToTarget];
        if (NULL != self.actionBlock) {
            self.actionBlock();
        }
    });
}
@end
