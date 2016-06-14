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

#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKHeaderBar+Actions.h"

@implementation GTKHeaderBar (Actions)
- (void)addWidgetAtStart:(GTKWidget *)child
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  child.parent = self;
  gtk_header_bar_pack_start(GTK_HEADER_BAR(self.widget),
      GTK_WIDGET(child.widget));
}

- (void)addWidgetAtEnd:(GTKWidget *)child
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  child.parent = self;
  gtk_header_bar_pack_start(GTK_HEADER_BAR(self.widget),
      GTK_WIDGET(child.widget));
}
@end
