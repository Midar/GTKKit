#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKGrid.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKGrid (Actions)
- (void)attachWidget: (GTKWidget*)childWidget
    left: (int)left
     top: (int)top
         width: (int)width
        height: (int)height;
- (void)attachWidget: (GTKWidget*)childWidget
      toWidget: (GTKWidget*)siblingWidget
        onSide: (GtkPositionType)side
         width: (int)width
        height: (int)height;
- (void)insertRowAtPosition: (int)position;
- (void)insertColumnAtPosition: (int)position;
- (void)removeRow: (int)position;
- (void)removeColumn: (int)position;
@end

OF_ASSUME_NONNULL_END
