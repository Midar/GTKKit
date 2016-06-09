#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKListBox.h"
#import "GTKListBoxRow.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKListBox (Properties)
- (void)prependWidget:(GTKWidget*)childWidget;
- (void)appendWidget:(GTKWidget*)childWidget;
- (void)insertWidget:(GTKWidget*)childWidget
          atPosition:(int)position;
- (void)selectRow:(GTKListBoxRow*)row;
- (void)unselectRow:(GTKListBoxRow*)row;
- (void)selectAll;
- (void)unselectAll;
- (GTKListBoxRow*)rowAtIndex:(int)index;
- (GTKListBoxRow*)widgetForSelectedRow;
@end

OF_ASSUME_NONNULL_END
