#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKWidget.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKImage: GTKWidget

@property OF_NULLABLE_PROPERTY (strong) OFString *imageFile;

@property OF_NULLABLE_PROPERTY (strong) OFString *iconName;

@property GtkIconSize iconSize;

@end

OF_ASSUME_NONNULL_END
