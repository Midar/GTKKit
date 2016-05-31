#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKWidget.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKWidget (Properties)
@property (copy) OFString *name;
@property bool sensitive;
@property (readonly) bool effectiveSensitivity;
@property double opacity;
@property (readonly) bool isFocus;
@property GtkAlign horizontalAlign;
@property GtkAlign verticalAlign;
@property int marginStart;
@property int marginEnd;
@property int marginTop;
@property int marginBottom;
@property bool expandHorizontal;
@property bool expandVertical;
@property int widthRequest;
@property int heightRequest;
@end

OF_ASSUME_NONNULL_END
