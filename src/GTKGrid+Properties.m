#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKGrid.h"

@implementation GTKGrid (Properties)
- (GtkOrientation)orientation
{
  return gtk_orientable_get_orientation (GTK_ORIENTABLE (self.widget));
}

- (void)setOrientation:(GtkOrientation)orientation
{
  gtk_orientable_set_orientation (GTK_ORIENTABLE (self.widget), orientation);
}

- (void)setColumnsHomogeneous:(bool)setting
{
  gtk_grid_set_column_homogeneous (GTK_GRID (self.widget), setting);
}

- (bool)columnsHomogeneous
{
  return gtk_grid_get_column_homogeneous (GTK_GRID (self.widget));
}

- (void)setRowsHomogeneous:(bool)setting
{
  gtk_grid_set_row_homogeneous (GTK_GRID (self.widget), setting);
}

- (bool)rowsHomogeneous
{
  return gtk_grid_get_row_homogeneous (GTK_GRID (self.widget));
}

- (unsigned int)rowSpacing
{
  return gtk_grid_get_row_spacing (GTK_GRID (self.widget));
}

- (void)setRowSpacing:(unsigned int)spacing
{
  gtk_grid_set_row_spacing (GTK_GRID (self.widget), spacing);
}

- (unsigned int)columnSpacing
{
  return gtk_grid_get_column_spacing (GTK_GRID (self.widget));
}

- (void)setColumnSpacing:(unsigned int)spacing
{
  gtk_grid_set_column_spacing (GTK_GRID (self.widget), spacing);
}

- (int)baselineRow
{
  return gtk_grid_get_baseline_row (GTK_GRID (self.widget));
}

- (void)setBaselineRow:(int)row
{
  gtk_grid_set_baseline_row (GTK_GRID (self.widget), row);
}

- (GtkBaselinePosition)baselinePositionForRow:(int)row
{
  return gtk_grid_get_row_baseline_position (GTK_GRID (self.widget), row);
}

- (id)baselinePosition:(GtkBaselinePosition)position
                forRow:(int)row
{
  gtk_grid_set_row_baseline_position (GTK_GRID (self.widget), row, position);
  return self;
}
@end
