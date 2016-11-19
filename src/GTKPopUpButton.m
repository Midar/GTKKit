/*! @file GTKPopUpButton.m
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

#import "GTKPopUpButton.h"
#import "GTKApplication.h"
#import "OFArray+GTKCoding.h"

@interface GTKPopUpButton ()
- (void)selectedItemChanged:(nonnull GTKEvent *)event;
@end

static void
changed_handler(GtkComboBox *widget, GTKPopUpButton *button)
{
    [GTKApp.dispatch.main async: ^ {
        GTKEvent *evt = [GTKEvent new];
        evt.type = GTKEventTypeMouseClicked;
        evt.mouseButton = 1;
        [button selectedItemChanged: evt];
    }];
}

@implementation GTKPopUpButton
- init
{
    self = [super init];
    _items = [OFMutableArray new];
    [GTKApp.dispatch.gtk sync: ^{
        g_signal_connect(
            G_OBJECT(self.mainWidget),
            "changed",
            G_CALLBACK(changed_handler),
            (__bridge gpointer)(self));
    }];
    return self;
}

- (instancetype)initWithCoder:(GTKCoder *)decoder
{
	self = [super initWithCoder: decoder];
    for (OFString *title in [decoder decodeObjectForKey: @"GTKKit.coding.popUpButton.popUpItems"]) {
        [self insertItemWithTitle: title at: -1];
    }
    return self;
}

- (void)encodeWithCoder:(GTKCoder *)encoder
{
    [super encodeWithCoder: encoder];
    [encoder encodeObject: _items forKey: @"GTKKit.coding.popUpButton.popUpItems"];
}

- (void)createMainWidget
{
    [GTKApp.dispatch.gtk sync: ^ {
        self.mainWidget = gtk_combo_box_text_new();
    }];
}

- (void)insertItemWithTitle:(OFString *)string
                         at:(int)index
{
    if (index < 0) {
        [_items addObject: string];
    } else {
        [_items insertObject: string atIndex: index];
    }
    [GTKApp.dispatch.gtk sync: ^{
        gtk_combo_box_text_insert(
            GTK_COMBO_BOX_TEXT(self.mainWidget),
            index,
            NULL,
            string.UTF8String);
    }];
}

- (void)removeItemAt:(int)index
{
    [_items removeObjectAtIndex: index];
    [GTKApp.dispatch.gtk sync: ^{
        gtk_combo_box_text_remove(
            GTK_COMBO_BOX_TEXT(self.mainWidget),
            index);
    }];
}

- (void)selectedItemChanged:(nonnull GTKEvent*)event
{
    [GTKApp.dispatch.main sync: ^{
        [self sendActionToTarget];
        if (NULL != self.actionBlock) {
            self.actionBlock();
        }
    }];
}

- (int)indexOfSelectedItem
{
    __block int activeIndex;
    [GTKApp.dispatch.gtk sync: ^{
        activeIndex = gtk_combo_box_get_active(GTK_COMBO_BOX(self.mainWidget));
    }];
    return activeIndex;
}

- (OFString *)titleOfSelectedItem
{
    __block OFString *title;
    __block char *str;
    [GTKApp.dispatch.gtk sync: ^{
        str = gtk_combo_box_text_get_active_text(GTK_COMBO_BOX_TEXT(self.mainWidget));
        if (NULL == str) {
            str = "";
        }
        title = [OFString stringWithUTF8String: str];
    }];
    return title;
}

- (void)selectItemAt:(int)activeIndex
{
    [GTKApp.dispatch.gtk sync: ^{
        gtk_combo_box_set_active(GTK_COMBO_BOX(self.mainWidget), activeIndex);
    }];
}

- (void)removeAllItems
{
    [_items removeAllObjects];
    [GTKApp.dispatch.gtk sync: ^{
        gtk_combo_box_text_remove_all(GTK_COMBO_BOX_TEXT(self.mainWidget));
    }];
}
@end
