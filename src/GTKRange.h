#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKWidget.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKRange: GTKWidget
{
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
@property (nonatomic) double minValue;
@property (nonatomic) double maxValue;
- (void)minValue:(double)min maxValue:(double)max;
@end

OF_ASSUME_NONNULL_END
