/*! @file GTKButton.h
 *
 * Copyright (c) 2014, 2015, 2016
 *   Kyle Cardoza <Kyle.Cardoza@icloud.com>
 *
 * All rights reserved.
 *
 * This file is part of GTKKit. It may be distributed under the terms of the
 * 2-clause BSD License, which can be found in the file COPYING.BSD included in
 * the packaging of this file.
 *
 * Alternatively, it may be distributed under the terms of the GNU Lesser
 * General Public License, either version 2 or 3, which can be found in the
 * files COPYING.LGPL2 and COPYING.LGPL3, respectively, both also included in
 * the packaging of this file.
 */

#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>

#import "GTKSlider.h"
#import "GTKCallback.h"

static void
value_changed_handler(GtkScale *scale, gpointer userdata)
{
    GTKSlider *slider = (__bridge GTKSlider *)(userdata);

	OFTimer *timer = [OFTimer
		timerWithTimeInterval: 0
		repeats: false
		block: ^ (OFTimer *timer) {
            [slider sendActionToTarget];
            if (NULL != slider.actionBlock) {
                slider.actionBlock();
            }
    }];

	[[OFRunLoop mainRunLoop] addTimer: timer];
}

@implementation GTKSlider
- init
{
    self = [super init];
    _min = 0.0;
    _max = 100.0;
    gtk_range_set_range(GTK_RANGE(self.mainWidget), _min, _max);
    self.showFillLevel = false;
    self.fillLevel = 0.0;
    self.doubleValue = 0.0;
    self.restrictToFillLevel = false;
    self.inverted = false;
    self.increment = 1.0;
    self.roundDigits = 0;
    return self;
}

- (void)createMainWidget
{
    self.mainWidget = gtk_scale_new(GTK_ORIENTATION_HORIZONTAL, NULL);
    _orientation = GTKSliderOrientationHorizontal;
    _valueChangedHandlerID = g_signal_connect(
        G_OBJECT(self.mainWidget),
        "value-changed",
        G_CALLBACK(value_changed_handler),
        (__bridge gpointer)(self));
    gtk_range_set_flippable(GTK_RANGE(self.mainWidget), true);
}

- (GTKSliderOrientation)orientation
{
    return _orientation;
}

- (void)setOrientation:(GTKSliderOrientation)orientation
{
    if (orientation == _orientation) {
        return;
    }

    double fillLevel = self.fillLevel;
    double value = self.doubleValue;
    bool restrictToFillLevel = self.restrictToFillLevel;
    bool showFillLevel = self.showFillLevel;
    bool inverted = self.isInverted;
    double increment = self.increment;
    int roundDigits = self.roundDigits;

    [GTKCallback sync: ^{
        gtk_widget_destroy(self.mainWidget);
        _orientation = orientation;

        if (_orientation == GTKSliderOrientationHorizontal) {
            self.mainWidget = gtk_scale_new(GTK_ORIENTATION_HORIZONTAL, NULL);
        } else {
            self.mainWidget = gtk_scale_new(GTK_ORIENTATION_VERTICAL, NULL);
        }

        gtk_range_set_range(GTK_RANGE(self.mainWidget), _min, _max);

        _valueChangedHandlerID = g_signal_connect(
            G_OBJECT(self.mainWidget),
            "value-changed",
            G_CALLBACK(value_changed_handler),
            (__bridge gpointer)(self));

        gtk_container_add(GTK_CONTAINER(self.overlayWidget), self.mainWidget);
        gtk_widget_show(self.mainWidget);
        gtk_range_set_flippable(GTK_RANGE(self.mainWidget), true);
    }];

    self.roundDigits = roundDigits;
    self.increment = increment;
    self.inverted = inverted;
    self.showFillLevel = showFillLevel;
    self.restrictToFillLevel = restrictToFillLevel;
    self.doubleValue = value;
    self.fillLevel = fillLevel;
}

- (double)minValue
{
    return _min;
}

- (void)setMinValue:(double)min
{
    _min = min;
    [GTKCallback sync: ^{
        gtk_range_set_range(GTK_RANGE(self.mainWidget), _min, _max);
    }];
}

- (double)maxValue
{
    return _max;
}

- (void)setMaxValue:(double)max
{
    _max = max;
    [GTKCallback sync: ^{
        gtk_range_set_range(GTK_RANGE(self.mainWidget), _min, _max);
    }];
}

- (double)doubleValue
{
    __block double doubleValue;
    [GTKCallback sync: ^{
        doubleValue = gtk_range_get_value(GTK_RANGE(self.mainWidget));
    }];
    return doubleValue;
}

- (void)setDoubleValue:(double)doubleValue
{
    [GTKCallback sync: ^{
        gtk_range_set_value(GTK_RANGE(self.mainWidget), doubleValue);
    }];
}

- (int)intValue
{
    __block double doubleValue;
    [GTKCallback sync: ^{
        doubleValue = gtk_range_get_value(GTK_RANGE(self.mainWidget));
    }];
    return (int)(ceil(doubleValue));
}

- (void)setIntValue:(int)intValue
{
    [GTKCallback sync: ^{
        gtk_range_set_value(GTK_RANGE(self.mainWidget), (double)(intValue));
    }];
}

- (float)floatValue
{
    __block double doubleValue;
    [GTKCallback sync: ^{
        doubleValue = gtk_range_get_value(GTK_RANGE(self.mainWidget));
    }];
    return (float)(doubleValue);
}

- (void)setFloatValue:(float)floatValue
{
    [GTKCallback sync: ^{
        gtk_range_set_value(GTK_RANGE(self.mainWidget), (double)(floatValue));
    }];
}

- (bool)restrictToFillLevel
{
    return _restrict;
}

- (void)setRestrictToFillLevel:(bool)restrictToFillLevel
{
    _restrict = restrictToFillLevel;
    [GTKCallback sync: ^{
        gtk_range_set_restrict_to_fill_level(GTK_RANGE(self.mainWidget), _restrict);
    }];
}

- (double)fillLevel
{
    return _fillLevel;
}

- (void)setFillLevel:(double)fillLevel
{
    _fillLevel = fillLevel;
    [GTKCallback sync: ^{
        gtk_range_set_fill_level(GTK_RANGE(self.mainWidget), _fillLevel);
    }];
}

- (bool)showFillLevel
{
    return _showFillLevel;
}

- (void)setShowFillLevel:(bool)showFillLevel
{
    _showFillLevel = showFillLevel;
    [GTKCallback sync: ^{
        gtk_range_set_show_fill_level(GTK_RANGE(self.mainWidget), _showFillLevel);
    }];
}

- (bool)isInverted
{
    return _inverted;
}

- (void)setInverted:(bool)inverted
{
    _inverted = inverted;
    [GTKCallback sync: ^{
        gtk_range_set_inverted(GTK_RANGE(self.mainWidget), _inverted);
    }];
}

- (double)increment
{
    return _increment;
}

- (void)setIncrement:(double)increment
{
    _increment = increment;
    [GTKCallback sync: ^{
        gtk_range_set_increments(GTK_RANGE(self.mainWidget), _increment, _increment);
    }];
}

- (int)roundDigits
{
    return _roundDigits;
}

- (void)setRoundDigits:(int)roundDigits
{
    _roundDigits = roundDigits;
    [GTKCallback sync: ^{
        gtk_scale_set_digits(GTK_SCALE(self.mainWidget), _roundDigits);
    }];
}

- (bool)showValue
{
    return _showValue;
}

- (void)setShowValue:(bool)showValue
{
    _showValue = showValue;
    [GTKCallback sync: ^{
        gtk_scale_set_draw_value(GTK_SCALE(self.mainWidget), _showValue);
    }];
}

- (GTKPositionType)valuePosition
{
    return _valuePosition;
}

- (void)setValuePosition:(GTKPositionType)valuePosition
{
    _valuePosition = valuePosition;
    [GTKCallback sync: ^{
        gtk_scale_set_value_pos(GTK_SCALE(self.mainWidget), (GtkPositionType)(_valuePosition));
    }];
}

- (bool)highlightOrigin
{
    return _highlightOrigin;
}

- (void)setHighlightOrigin:(bool)highlightOrigin
{
    _highlightOrigin = highlightOrigin;
    [GTKCallback sync: ^{
        gtk_scale_set_has_origin(GTK_SCALE(self.mainWidget), _highlightOrigin);
    }];
}
@end
