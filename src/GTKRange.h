#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "typedefs.h"
#import "GTKWidget.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKRange: GTKWidget {
  double _min;
  double _max;
}
@property double fillLevel;
@property bool restrictToFillLevel;
@property bool showFillLevel;
@property bool inverted;
@property double value;
@property (nonatomic) double stepSize;
@property int roundDigts;
@property (nonatomic) double min;
@property (nonatomic) double max;
- (void)min:(double)min max:(double)max;
@end

OF_ASSUME_NONNULL_END
