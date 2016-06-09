#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKBin.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKComboBox: GTKBin
- (void)    appendString: (OFString*)string
    withIdentifierString: (OFString*)ID;
- (void)   prependString: (OFString*)string
    withIdentifierString: (OFString*)ID;
- (void)    insertString: (OFString*)string
    withIdentifierString: (OFString*)ID
              atPosition: (int)position;
@end

OF_ASSUME_NONNULL_END
