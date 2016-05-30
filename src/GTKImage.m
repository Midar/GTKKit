#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKImage.h"

@implementation GTKImage

@synthesize imageFile = _imageFile;

- (id)createWidget {
  self.widget = gtk_image_new_from_icon_name("dialog-question", GTK_ICON_SIZE_DIALOG);
	return self;
}

- (void)setImageFile:(NSString *)filename {
  _imageFile = filename;
  gtk_image_set_from_file(GTK_IMAGE(self.widget), [filename UTF8String]);
}

- (OFString *)imageFile {
  return _imageFile;
}

@end
