/*! @file GTKSegmentedControl.h
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

#import "GTKControl.h"
#import "GTKImage.h"
#import "GTKPopOverViewController.h"

#define GTK_SEGMENTED_CONTROL_MAX_SEGMENTS 32SegmentedControlMode;

/*!
 * @brief The tracking modes available to segmented controls.
 */
typedef enum GTKSegmentSwitchTracking {
    /*!
     * @brief Select one segment at a time.
     */
    GTKSegmentSwitchTrackingSelectOne,
    /*!
     * @brief Select any or all of the segments at once.
     */
    GTKSegmentSwitchTrackingSelectAny,
    /*!
     * @brief Make the control act like a row of momentary pushbuttons.
     */
    GTKSegmentSwitchTrackingMomentary
} GTKSegmentSwitchTracking;

/*!
 * @brief A class implementing a row of up to 32 buttons with a common purpose.
 *
 * The major distinction between a segmented control and a mere collection of
 * GTKButton instances is that no matter how many segments a segmented control
 * has, there is only one target-action pair and one action block for the entire
 * control.
 */
@interface GTKSegmentedControl: GTKControl
{
    int _buttonIndex[32];
    GtkWidget *_buttons[32];
    int _segments;
    OFMutableArray *_labelForSegment;
    OFMutableArray *_imageForSegment;
    OFMutableArray *_popOverForSegment;
    OFMutableArray *_iconNameForSegment;
    bool _momentary;
    GTKSegmentSwitchTracking _trackingMode;
}


/*!
 * @brief The tracking mode of the control.
 */
@property GTKSegmentSwitchTracking trackingMode;
@property (getter=isMomentary) bool momentary;
@property bool selectAny;

/*!
 * @brief The number of segments int the control; can be any integer from 0 to 32.
 */
@property int segments;

/*!
 * @brief The index of the last segment to be selected.
 */
@property int selectedSegment;

/*!
 * @brief Sets the given string as the label for the specified segment.
 *
 * @param label The label to apply to the segment.
 * @param segment The segment to which the label should be applied.
 */
- (void)setLabel:(OFString *)label forSegment:(int)segment;

/*!
 * @brief Gets the label for the specified segment, if one exists.
 *
 * @param segment The segment from which the label should be returned.
 *
 * @returns An OFString representing the label, or nil if there is no label.
 */
- (OFString *)labelForSegment:(int)segment;

/*!
 * @brief Sets the given image as the image for the specified segment.
 *
 * @param image The GTKImage to apply to the segment.
 * @param segment The segment to which the image should be applied.
 */
- (void)setImage:(GTKImage *)image forSegment:(int)segment;

/*!
 * @brief Gets the image for the specified segment, if one exists.
 *
 * @param segment The segment for which the image should be returned.
 *
 * @returns The GTKImage instance used by the segment, or nil if there is no image.
 */
- (GTKImage *)imageForSegment:(int)segment;

/*!
 * @brief Sets the given GTKPopOverViewController as the pop-over for the specified segment.
 *
 * @param popOver The GTKPopOverViewController to attach to the segment.
 * @param segment The segment to which the pop-over should be attached.
 */
- (void)setPopOver:(GTKPopOverViewController *)popOver forSegment:(int)segment;

/*!
 * @brief Gets the GTKPopOverViewController for the specified segment, if one exists.
 *
 * @param segment The segment for which the pop-over should be returned.
 *
 * @returns The GTKPopOverViewController attached to the segment, or nil if there is no pop-over.
 */
- (GTKPopOverViewController *)popOverForSegment:(int)segment;

/*!
 * @brief The state of the specified statement, i.e. if it is pressed or not. This
 * always returns GTKOffState when the control is momentary.
 *
 * @param segment The segment for which the state should be returned.
 *
 * @returns The state of the segment, either GTKOnState or GTKOffState.
 */
- (bool)stateForSegment:(int)segment;

/*!
 * @brief Sets the state for the specified segment. This is only useful if the
 * control is not momentary.
 *
 * @param state The state to apply to the segment.
 * @param segment The segment to which the state should be applied.
 */
- (void)setState:(bool)state forSegment:(int)segment;

/*!
 * @brief Sets the specified icon name as the icon for the specified segment.
 *
 * @param name The GTKPopOverViewController to attach to the segment.
 * @param segment The segment to which the pop-over should be attached.
 */
- (void)setIconName:(OFString *)name forSegment:(int)segment;
@end
