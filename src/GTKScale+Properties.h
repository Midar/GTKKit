#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKScale.h"
#import "Orientable.h"
#import "typedefs.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKScale (Properties) <Orientable>

@property int digits;
@property bool drawValue;
@property bool hasOrigin;
@property GtkPositionType valuePosition;

- (void)addMarkAtValue:(double)value
          withPosition:(GtkPositionType) pos
              withText:(OFString *) text;

- (void)addMarkAtValue:(double)value;

- (void)addMarkAtValue:(double)value
          withPosition:(GtkPositionType) pos;

- (void)addMarkAtValue:(double)value
              withText:(OFString *) text;

- (void)clearMarks;

@end

OF_ASSUME_NONNULL_END
