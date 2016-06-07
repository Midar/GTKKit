#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKContainer.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKListBox: GTKContainer {
  gulong _selectedRowsChangedHandlerID;
}
@property (weak) id target;
@property SEL action;
@end

OF_ASSUME_NONNULL_END
