#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKContainer.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKGrid (Properties)
@property GtkOrientation orientation;
@property bool columnsHomogeneous;
@property bool rowsHomogeneous;
@property unsigned int rowSpacing;
@property unsigned int columnsSpacing;
@property int baselineRow;
- (GtkBaselinePosition)baselinePositionForRow: (int)row;
- (id)baselinePosition: (GtkBaselinePosition)position
                forRow: (int)row;
@end

OF_ASSUME_NONNULL_END
