/*! @file GTKComboBox.m
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

#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>

#import "GTKComboBox.h"


/*!
 * @brief A button with an associated menu of items, any of which can be
 * selected, which contains a text entry field.
 */
@implementation GTKComboBox: GTKPopUpButton
- (void)createMainWidget
{
    [GTKApp.dispatch.gtk sync: ^{
        self.mainWidget = gtk_combo_box_text_new_with_entry();
    }];
}
@end
