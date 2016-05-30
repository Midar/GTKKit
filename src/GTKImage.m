#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKImage.h"

@implementation GTKImage

@synthesize imageFile = _imageFile;
@synthesize iconName = _iconName;

- (id)createWidget {
  self.iconSize = GTK_ICON_SIZE_DIALOG;
  self.widget = gtk_image_new_from_icon_name("dialog-question", self.iconSize);
	return self;
}

- (void)setImageFile:(OFString *)filename {
  _imageFile = filename;
  gtk_image_set_from_file(GTK_IMAGE(self.widget), [filename UTF8String]);
}

- (OFString *)imageFile {
  return _imageFile;
}

- (void)setIconName:(OFString *)name {
  _iconName = name;
  gtk_image_set_from_icon_name(GTK_IMAGE(self.widget), [name UTF8String], self.iconSize);
}

- (OFString *)iconName {
  return _iconName;
}

@end
