#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKBin.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKListBoxRow: GTKBin
{
  __weak GTKWidget *_rowHeader;
}
@property (readonly) bool selected;
@property GTKWidget *rowHeader;
@property (readonly) int rowIndex;
@property bool activatable;
@property bool selectable;
- (void)rowChanged;
@end

OF_ASSUME_NONNULL_END
