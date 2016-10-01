/*

GTKEvent is a class implementing objects which represent an event in the system.
It is a general data object, used to represent various kinds of event. As such,
it is not likely that all of this object's properties will ever be used at once.

*/

#import <ObjFW/ObjFW.h>

#import "defines.h"

typedef OF_ENUM(int, GTKEventType) {
    GTKEventTypeKeyDown,
    GTKEventTypeKeyUp,
    GTKEventTypeMouseDown,
    GTKEventTypeMouseUp
};

typedef struct GTKEventKeyboardModifiers {
    bool control;
    bool alt;
    bool shift;
} GTKEventKeyboardModifiers;

@interface GTKEvent: OFObject

@property GTKEventType type;

@property unsigned int mouseButton;
@property unsigned int mouseX;
@property unsigned int mouseY;

@property double deltaX;
@property double deltaY;
@property double deltaZ;

@property char character;
@property GTKEventKeyboardModifiers modifierKeys;

@end
