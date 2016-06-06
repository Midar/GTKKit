#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKWidget.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKEntry: GTKWidget
@property GtkEntryBuffer *buffer;
@property id stringValue;
@property bool textVisible;
@property int maximumLength;
@property bool hasFrame;
@end

OF_ASSUME_NONNULL_END
