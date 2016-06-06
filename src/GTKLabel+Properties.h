#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKLabel.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKLabel (Properties)
@property OFString *label;
@property float xAlign;
@property float yAlign;
@property GtkJustification justify;
@property PangoEllipsizeMode ellipsizeMode;
@property int desiredWidthInCharacters;
@property bool wrap;
@property PangoWrapMode lineWrapMode;
@property bool selectable;
@property bool singleLineMode;
@property double angle;
@end

OF_ASSUME_NONNULL_END
