#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

OF_ASSUME_NONNULL_BEGIN

@interface GTKWidget: OFObject
@property GtkWidget *widget;
+ (instancetype)widgetFromGtkWidget: (GtkWidget*)w;
@end

OF_ASSUME_NONNULL_END
