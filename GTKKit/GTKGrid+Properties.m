#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import <GTKKit/GTKGrid.h>

@implementation GTKGrid (Properties)

- (GtkOrientation)orientation {
	return gtk_orientable_get_orientation (GTK_ORIENTABLE (widget));
}

- (id)orientation:(GtkOrientation)orientation {
	gtk_orientable_set_orientation (GTK_ORIENTABLE (widget), orientation);
	return self;
}

- (id)columnsHomogeneous:(bool)setting {
	gtk_grid_set_column_homogeneous (GTK_GRID (widget), setting);
	return self;
}

- (bool)columnsHomogeneous {
	return gtk_grid_get_column_homogeneous (GTK_GRID (widget));
}

- (id)rowsHomogeneous:(bool)setting {
	gtk_grid_set_row_homogeneous (GTK_GRID (widget), setting);
	return self;
}

- (bool)rowsHomogeneous {
	return gtk_grid_get_row_homogeneous (GTK_GRID (widget));
}

- (unsigned int)rowSpacing {
	return gtk_grid_get_row_spacing (GTK_GRID (widget));
}

- (id)rowSpacing:(unsigned int)spacing {
	gtk_grid_set_row_spacing (GTK_GRID (widget), spacing);
	return self;
}

- (unsigned int)columnSpacing {
	return gtk_grid_get_column_spacing (GTK_GRID (widget));
}

- (id)columnSpacing:(unsigned int)spacing {
	gtk_grid_set_column_spacing (GTK_GRID (widget), spacing);
	return self;
}

- (int)baselineRow {
	return gtk_grid_get_baseline_row (GTK_GRID (widget));
}

- (id)baselineRow:(int)row {
	gtk_grid_set_baseline_row (GTK_GRID (widget), row);
	return self;
}

- (GtkBaselinePosition)baselinePositionForRow:(int)row {
	return gtk_grid_get_row_baseline_position (GTK_GRID (widget), row);
}

- (id)baselinePosition:(GtkBaselinePosition)position forRow:(int)row {
	gtk_grid_set_row_baseline_position (GTK_GRID (widget), row, position);
	return self;
}

@end
