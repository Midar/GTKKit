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

#import "GTKGrid+Actions.h"

@implementation GTKGrid (Actions)
- (void)attachWidget: (GTKWidget*)childWidget
                left: (int)left
                 top: (int)top
               width: (int)width
              height: (int)height
{
  gtk_grid_attach(GTK_GRID(self.widget), GTK_WIDGET(childWidget.widget),
      left, top, width, height);
}

- (void)attachWidget: (GTKWidget*)childWidget
            toWidget: (GTKWidget*)siblingWidget
              onSide: (GtkPositionType)side
               width: (int)width
              height: (int)height
{
  gtk_grid_attach_next_to(GTK_GRID(self.widget),
      GTK_WIDGET(childWidget.widget), GTK_WIDGET(siblingWidget.widget),
      side, width, height);
}

- (void)insertRowAtPosition: (int)position
{
  gtk_grid_insert_row(GTK_GRID(self.widget), position);
}

- (void)insertColumnAtPosition: (int)position
{
  gtk_grid_insert_column(GTK_GRID(self.widget), position);
}

- (void)removeRow: (int)position
{
  gtk_grid_remove_row(GTK_GRID(self.widget), position);
}

- (void)removeColumn: (int)position
{
  gtk_grid_remove_column(GTK_GRID(self.widget), position);
}
@end
