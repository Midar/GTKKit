#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKWidget.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKImage: GTKWidget
{
    OFString *_imageFile;
    OFString *_iconName;
}
@property OFString *imageFile;
@property OFString *iconName;
@property GtkIconSize iconSize;
@end

OF_ASSUME_NONNULL_END
