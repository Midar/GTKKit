#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "typedefs.h"

OF_ASSUME_NONNULL_BEGIN

/**
 * \brief Widget parent class.
 *
 * GTKWidget is the parent class for all the wrapper classes found in GTKKit.
 * It is not to be instantiated itself, but the methods it implements are
 * critical for all other UI* classes.
 */
@interface GTKWidget: OFObject
@property (assign) GtkWidget *widget;
@property OF_NULLABLE_PROPERTY (copy) GTKCallback onDestroy;

/**
 * Create a new widget.
 *
 * @returns an initialized widget object.
 */
+ (instancetype)new;

/**
 * Create a new widget object using a raw C GtkWidget.
 *
 * @param w the GtkWidget to wrap in a widget instance.
 * @returns an initialized widget object.
 */
+ (instancetype)widgetFromGtkWidget: (GtkWidget*)w;

- (instancetype)init;

- (instancetype)createWidget;

@end

OF_ASSUME_NONNULL_END
