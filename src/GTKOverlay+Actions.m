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

#import "GTKOverlay.h"
#import "GTKOverlay+Actions.h"

@implementation GTKOverlay (Actions)
- (void)addOverlayChild:(GTKWidget*)child
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_overlay_add_overlay(GTK_OVERLAY(self.widget), GTK_WIDGET([child widget]));
}

- (void)reorderOverlayChild:(GTKWidget*)child
                    toIndex:(int)index
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_overlay_reorder_overlay(GTK_OVERLAY(self.widget),
      GTK_WIDGET([child widget]), index);
}
@end
