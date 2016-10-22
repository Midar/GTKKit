/*! @file GTKTextField.m
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

#import "GTKTextField.h"
#import "GTKCallback.h"

static void
entry_activated_handler(GtkEntry *entry, gpointer userdata)
{
    GTKTextField *field = (__bridge GTKTextField *)(userdata);

	OFTimer *timer = [OFTimer
		timerWithTimeInterval: 0
		repeats: false
		block: ^ (OFTimer *timer) {
            [field sendActionToTarget];
            if (NULL != field.actionBlock) {
                field.actionBlock();
            }
    }];

	[[OFRunLoop mainRunLoop] addTimer: timer];
}

static void
entry_insert_at_cursor_handler(GtkEntry *entry, gpointer userdata)
{
    GTKTextField *field = (__bridge GTKTextField *)(userdata);

    if (field.isContinuous) {
    	OFTimer *timer = [OFTimer
    		timerWithTimeInterval: 0
    		repeats: false
    		block: ^ (OFTimer *timer) {
                [field sendActionToTarget];
                if (NULL != field.actionBlock) {
                    field.actionBlock();
                }
        }];

    	[[OFRunLoop mainRunLoop] addTimer: timer];
    }
}

static gboolean
text_view_focus_out_handler(GtkTextView *textView, GdkEvent *event, gpointer userdata)
{
    GTKTextField *field = (__bridge GTKTextField *)(userdata);

	OFTimer *timer = [OFTimer
		timerWithTimeInterval: 0
		repeats: false
		block: ^ (OFTimer *timer) {
            [field sendActionToTarget];
            if (NULL != field.actionBlock) {
                field.actionBlock();
            }
    }];

	[[OFRunLoop mainRunLoop] addTimer: timer];

    return false;
}

@implementation GTKTextField
- (void)createMainWidget
{
    _editable = false;
    [GTKCallback sync: ^{
        self.mainWidget = gtk_label_new(NULL);
    }];
}

- init
{
    self = [super init];
    self.editable = false;
    self.multiline = false;
    self.selectable = false;
    self.justify = GTKJustificationCenter;
    self.continuous = false;
    return self;
}

- (bool)isEditable
{
    return _editable;
}

- (void)setEditable:(bool)editable
{
    if (_editable == editable) {
        return;
    }
    OFString *stringValue = self.stringValue;
    GTKJustification justify = self.justify;
    bool selectable = self.selectable;
    _editable = editable;
    [GTKCallback sync: ^{
        gtk_widget_destroy(self.mainWidget);
        if (_editable == true) {
            if (_multiline == true) {
                self.mainWidget = gtk_text_view_new();
                _textViewFocusOutHandlerID = g_signal_connect(
                    G_OBJECT(self.mainWidget),
                    "focus-out-event",
                    G_CALLBACK(text_view_focus_out_handler),
                    (__bridge gpointer)(self));
            } else {
                self.mainWidget = gtk_entry_new();
                _entryActivatedHandlerID = g_signal_connect(
                    G_OBJECT(self.mainWidget),
                    "activate",
                    G_CALLBACK(entry_activated_handler),
                    (__bridge gpointer)(self));
                _insertAtCursorHandlerID = g_signal_connect(
                    G_OBJECT(self.mainWidget),
                    "insert-at-cursor",
                    G_CALLBACK(entry_insert_at_cursor_handler),
                    (__bridge gpointer)(self));
            }
        } else {
            self.mainWidget = gtk_label_new(NULL);
        }
        gtk_widget_show(self.mainWidget);
        gtk_container_add(GTK_CONTAINER(self.overlayWidget), self.mainWidget);
    }];
    self.selectable = selectable;
    self.justify = justify;
    self.stringValue = stringValue;
}

- (OFString *)stringValue
{
    __block OFString *stringValue;
    __block const char *str;
    [GTKCallback sync: ^{
        if (_editable == true) {
            if (_multiline == true) {
                GtkTextBuffer *buf = gtk_text_view_get_buffer((GTK_TEXT_VIEW(self.mainWidget)));
                GtkTextIter start;
                GtkTextIter end;
                gtk_text_buffer_get_iter_at_offset(buf, &start, 0);
                gtk_text_buffer_get_iter_at_offset(buf, &end, -1);
                str = gtk_text_buffer_get_text(buf, &start, &end, true);
                stringValue = [OFString stringWithUTF8String: str];
                free((void *)(str));
            } else {
                str = gtk_entry_get_text(GTK_ENTRY(self.mainWidget));
            }
        } else {
            str = gtk_label_get_label(GTK_LABEL(self.mainWidget));
        }
        stringValue = [OFString stringWithUTF8String: str];
    }];
    return stringValue;
}

- (void)setStringValue:(OFString *)stringValue
{
    [GTKCallback sync: ^{
        if (_editable == true) {
            if (_multiline == true) {
                GtkTextBuffer *buf = gtk_text_view_get_buffer((GTK_TEXT_VIEW(self.mainWidget)));
                gtk_text_buffer_set_text(buf, stringValue.UTF8String, stringValue.length);
            } else {
                gtk_entry_set_text(GTK_ENTRY(self.mainWidget), stringValue.UTF8String);
            }
        } else {
            gtk_label_set_markup(GTK_LABEL(self.mainWidget), stringValue.UTF8String);
        }
    }];
}

- (bool)isSelectable
{
    return _selectable;
}

- (void)setSelectable:(bool)selectable
{
    _selectable = selectable;
    if (!self.isEditable) {
        [GTKCallback sync: ^{
            gtk_label_set_selectable(GTK_LABEL(self.mainWidget), selectable);
        }];
    }
}

- (bool)canBecomeFirstResponder
{
    return true;
}

- (bool)shouldBecomeFirstResponder
{
    return true;
}

- (void)didBecomeFirstResponder
{
    [GTKCallback sync: ^{
        gtk_widget_grab_focus(self.mainWidget);
        if (gtk_widget_get_can_default(self.mainWidget)) {
            gtk_widget_grab_default(self.mainWidget);
        }
    }];
}

- (GTKJustification)justify
{
    return _justify;
}

- (void)setJustify:(GTKJustification)justify
{
    _justify = justify;
    if (!self.isEditable) {
        [GTKCallback sync: ^{
            gtk_label_set_justify(GTK_LABEL(self.mainWidget), (GtkJustification)(_justify));
        }];
    }
}

- (bool)isMultiline
{
    return _multiline;
}

- (void)setMultiline:(bool)multiline
{
    if (multiline == _multiline) {
        return;
    }
    OFString *stringValue = self.stringValue;
    GTKJustification justify = self.justify;
    bool selectable = self.selectable;
    _multiline = multiline;
    [GTKCallback sync: ^{
        gtk_widget_destroy(self.mainWidget);
        if (self.isEditable) {
            if (_multiline == true) {
                self.mainWidget = gtk_text_view_new();
                _textViewFocusOutHandlerID = g_signal_connect(
                    G_OBJECT(self.mainWidget),
                    "focus-out-event",
                    G_CALLBACK(text_view_focus_out_handler),
                    (__bridge gpointer)(self));
            } else {
                self.mainWidget = gtk_entry_new();
                _entryActivatedHandlerID = g_signal_connect(
                    G_OBJECT(self.mainWidget),
                    "activate",
                    G_CALLBACK(entry_activated_handler),
                    (__bridge gpointer)(self));
                _insertAtCursorHandlerID = g_signal_connect(
                    G_OBJECT(self.mainWidget),
                    "insert-at-cursor",
                    G_CALLBACK(entry_insert_at_cursor_handler),
                    (__bridge gpointer)(self));
            }
        } else {
            self.mainWidget = gtk_label_new(NULL);
            gtk_label_set_line_wrap(GTK_LABEL(self.mainWidget), _multiline);
        }
        gtk_widget_show(self.mainWidget);
        gtk_container_add(GTK_CONTAINER(self.overlayWidget), self.mainWidget);
    }];
    self.selectable = selectable;
    self.justify = justify;
    self.stringValue = stringValue;
}
@end