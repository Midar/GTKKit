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

#import "GTKContainer+Actions.h"

@implementation GTKContainer (Actions)
- (void)addWidget: (GTKWidget*)childWidget
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_container_add(GTK_CONTAINER(self.widget), [childWidget widget]);
}

- (void)removeWidget: (GTKWidget*)childWidget
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_container_remove(GTK_CONTAINER(self.widget), [childWidget widget]);
}

- (void)addAll: (OFArray*)childWidgets
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  for (id childWidget in childWidgets)
    [self addWidget: childWidget];
}
@end
