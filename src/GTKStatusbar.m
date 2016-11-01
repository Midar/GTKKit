/*! @file GTKStatusbar.m
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

#import "GTKStatusbar.h"
#import "GTKApplication.h"

@implementation GTKStatusbar
- init
{
    self = [super init];
    [GTKApp.dispatch.gtk sync: ^{
        _contextID = gtk_statusbar_get_context_id(
            GTK_STATUSBAR(self.mainWidget),
            "GTKKit Internal Statusbar Context");
    }];
    return self;
}

- (void)createMainWidget
{
    [GTKApp.dispatch.gtk sync: ^{
        self.mainWidget = gtk_statusbar_new();
    }];
}

- (void)push:(OFString *)message
{
    [GTKApp.dispatch.gtk sync: ^{
        gtk_statusbar_push(
            GTK_STATUSBAR(self.mainWidget),
            _contextID,
            message.UTF8String);
    }];
}

- (void)pop
{
    [GTKApp.dispatch.gtk sync: ^{
        gtk_statusbar_pop(
            GTK_STATUSBAR(self.mainWidget),
            _contextID);
    }];
}

- (void)clear
{
    [GTKApp.dispatch.gtk sync: ^{
        gtk_statusbar_remove_all(
            GTK_STATUSBAR(self.mainWidget),
            _contextID);
    }];
}
@end
