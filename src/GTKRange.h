#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "typedefs.h"

#import "GTKWidget.h"

@interface GTKRange: GTKWidget

@property double fillLevel;

@property bool restrictToFillLevel;

@property bool showFillLevel;

@property bool inverted;

@property double value;

@property (nonatomic) double stepSize;

@property (nonatomic) double min;

@property (nonatomic) double max;

@property int roundDigts;

@end