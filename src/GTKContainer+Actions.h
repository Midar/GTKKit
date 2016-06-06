#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKContainer.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKContainer (Actions)
- (void)addWidget: (GTKWidget*)childWidget;
- (void)removeWidget: (GTKWidget*)childWidget;
- (void)addAll: (OFArray*)childWidgets;
@end

OF_ASSUME_NONNULL_END
