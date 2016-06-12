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

#import "GTKBin.h"

@implementation GTKBin

// This returns the wrapper object for the child widget, as a GTKWidget. It
// can and should be immediately cast to the appropriate class by the sender.
- (GTKWidget *)childWidget
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  GtkWidget *child = (GTK_WIDGET(gtk_bin_get_child(GTK_BIN(self.widget))));
  return [GTKWidget wrapperForGtkWidget: child];
}

@end
