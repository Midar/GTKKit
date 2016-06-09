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

#import "GTKGrid.h"

@implementation GTKGrid (Properties)
- (GtkOrientation)orientation
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_orientable_get_orientation (GTK_ORIENTABLE (self.widget));
}

- (void)setOrientation:(GtkOrientation)orientation
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_orientable_set_orientation (GTK_ORIENTABLE (self.widget), orientation);
}

- (void)setColumnsHomogeneous:(bool)setting
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_grid_set_column_homogeneous (GTK_GRID (self.widget), setting);
}

- (bool)columnsHomogeneous
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_grid_get_column_homogeneous (GTK_GRID (self.widget));
}

- (void)setRowsHomogeneous:(bool)setting
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_grid_set_row_homogeneous (GTK_GRID (self.widget), setting);
}

- (bool)rowsHomogeneous
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_grid_get_row_homogeneous (GTK_GRID (self.widget));
}

- (unsigned int)rowSpacing
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_grid_get_row_spacing (GTK_GRID (self.widget));
}

- (void)setRowSpacing:(unsigned int)spacing
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_grid_set_row_spacing (GTK_GRID (self.widget), spacing);
}

- (unsigned int)columnSpacing
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_grid_get_column_spacing (GTK_GRID (self.widget));
}

- (void)setColumnSpacing:(unsigned int)spacing
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_grid_set_column_spacing (GTK_GRID (self.widget), spacing);
}

- (int)baselineRow
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_grid_get_baseline_row (GTK_GRID (self.widget));
}

- (void)setBaselineRow:(int)row
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_grid_set_baseline_row (GTK_GRID (self.widget), row);
}

- (GtkBaselinePosition)baselinePositionForRow:(int)row
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_grid_get_row_baseline_position (GTK_GRID (self.widget), row);
}

- (id)baselinePosition:(GtkBaselinePosition)position
                forRow:(int)row
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_grid_set_row_baseline_position (GTK_GRID (self.widget), row, position);
  return self;
}
@end
