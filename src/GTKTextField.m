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
#import "GTKApplication.h"

static void
entry_activated_handler(GtkEntry *entry, GTKTextField *field)
{
    [GTKApp.dispatch.main async: ^ {
        [field sendActionToTarget];
        if (NULL != field.actionBlock) {
            field.actionBlock();
        }
    }];
}

static void
entry_insert_at_cursor_handler(GtkEntry *entry, GTKTextField *field)
{
    if (field.isContinuous) {
        [GTKApp.dispatch.main async: ^ {
            [field sendActionToTarget];
            if (NULL != field.actionBlock) {
                field.actionBlock();
            }
        }];
    }
}

static gboolean
text_view_focus_out_handler(GtkTextView *textView, GdkEvent *event, GTKTextField *field)
{
    [GTKApp.dispatch.main async: ^ {
        [field sendActionToTarget];
        if (NULL != field.actionBlock) {
            field.actionBlock();
        }
    }];
    return false;
}

@implementation GTKTextField
- (void)createMainWidget
{
    _editable = false;
    [GTKApp.dispatch.gtk sync: ^{
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
    [GTKApp.dispatch.gtk sync: ^{
        _scrollWindow = gtk_scrolled_window_new(NULL, NULL);
        g_object_ref(G_OBJECT(_scrollWindow));
        gtk_widget_show(_scrollWindow);
        GtkStyleContext *context = gtk_widget_get_style_context(_scrollWindow);
        gtk_style_context_add_class(context, "gtkkit-textview");
    }];
    return self;
}

- (instancetype)initWithCoder:(GTKCoder *)decoder
{
	self = [super initWithCoder: decoder];
    self.editable = [decoder decodeBoolForKey: @"editable"];
    self.continuous = [decoder decodeBoolForKey: @"continuous"];
    self.selectable = [decoder decodeBoolForKey: @"selectable"];
    OFString *justify = [decoder decodeStringForKey: @"justify"];
    if ([justify isEqual: @"left"]) {
        self.justify = GTKJustificationLeft;
    } else if ([justify isEqual: @"center"]) {
        self.justify = GTKJustificationCenter;
    } else if ([justify isEqual: @"right"]) {
        self.justify = GTKJustificationRight;
    } else if ([justify isEqual: @"fill"]) {
        self.justify = GTKJustificationFill;
    }
    self.multiline = [decoder decodeBoolForKey: @"multiline"];
    self.stringValue = [decoder decodeStringForKey: @"stringValue"];
    return self;
}

- (void)encodeWithCoder:(GTKCoder *)encoder
{
    [super encodeWithCoder: encoder];
    [encoder encodeBool: self.isEditable forKey: @"editable"];
    [encoder encodeBool: self.isContinuous forKey: @"continuous"];
    [encoder encodeBool: self.isSelectable forKey: @"selectable"];
    switch (self.justify) {
    case GTKJustificationLeft:
        [encoder encodeString: @"left" forKey: @"justify"];
        break;
    case GTKJustificationCenter:
        [encoder encodeString: @"center" forKey: @"justify"];
        break;
    case GTKJustificationRight:
        [encoder encodeString: @"right" forKey: @"justify"];
        break;
    case GTKJustificationFill:
        [encoder encodeString: @"fill" forKey: @"justify"];
        break;
    }
    [encoder encodeBool: self.isMultiline forKey: @"multiline"];
    [encoder encodeString: self.stringValue forKey: @"stringValue"];
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
    double alpha = self.alpha;
    OFString *stringValue = self.stringValue;
    GTKJustification justify = self.justify;
    bool selectable = self.selectable;
    _editable = editable;
    [GTKApp.dispatch.gtk sync: ^{
        gtk_widget_destroy(self.mainWidget);
        gtk_widget_destroy(_scrollWindow);
        _scrollWindow = gtk_scrolled_window_new(NULL, NULL);
        g_object_ref(G_OBJECT(_scrollWindow));
        gtk_widget_show(_scrollWindow);
        GtkStyleContext *context = gtk_widget_get_style_context(_scrollWindow);
        gtk_style_context_add_class(context, "gtkkit-textview");
        if (_editable == true) {
            if (_multiline == true) {
                self.mainWidget = gtk_text_view_new();
                gtk_text_view_set_border_window_size(
                    GTK_TEXT_VIEW(self.mainWidget),
                    GTK_TEXT_WINDOW_TOP,
                    8);
                gtk_text_view_set_border_window_size(
                    GTK_TEXT_VIEW(self.mainWidget),
                    GTK_TEXT_WINDOW_BOTTOM,
                    8);
                gtk_text_view_set_border_window_size(
                    GTK_TEXT_VIEW(self.mainWidget),
                    GTK_TEXT_WINDOW_LEFT,
                    8);
                gtk_text_view_set_border_window_size(
                    GTK_TEXT_VIEW(self.mainWidget),
                    GTK_TEXT_WINDOW_RIGHT,
                    8);
                g_signal_connect(
                    G_OBJECT(self.mainWidget),
                    "focus-out-event",
                    G_CALLBACK(text_view_focus_out_handler),
                    (__bridge gpointer)(self));
                gtk_container_add(
                    GTK_CONTAINER(_scrollWindow),
                    self.mainWidget);
                gtk_widget_show(self.mainWidget);
                gtk_container_add(GTK_CONTAINER(self.overlayWidget), _scrollWindow);
            } else {
                self.mainWidget = gtk_entry_new();
                g_signal_connect(
                    G_OBJECT(self.mainWidget),
                    "activate",
                    G_CALLBACK(entry_activated_handler),
                    (__bridge gpointer)(self));
                g_signal_connect(
                    G_OBJECT(self.mainWidget),
                    "insert-at-cursor",
                    G_CALLBACK(entry_insert_at_cursor_handler),
                    (__bridge gpointer)(self));
                gtk_widget_show(self.mainWidget);
                gtk_container_add(GTK_CONTAINER(self.overlayWidget), self.mainWidget);
            }
        } else {
            self.mainWidget = gtk_label_new(NULL);
            gtk_widget_show(self.mainWidget);
            gtk_container_add(GTK_CONTAINER(self.overlayWidget), self.mainWidget);
        }
    }];
    self.selectable = selectable;
    self.justify = justify;
    self.stringValue = stringValue;
    self.alpha = alpha;
    [self reconnectSignals];
}

- (OFString *)stringValue
{
    __block OFString *stringValue;
    __block const char *str;
    [GTKApp.dispatch.gtk sync: ^{
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
    [GTKApp.dispatch.gtk sync: ^{
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
        [GTKApp.dispatch.gtk sync: ^{
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
    [GTKApp.dispatch.gtk sync: ^{
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
        [GTKApp.dispatch.gtk sync: ^{
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
    double alpha = self.alpha;
    OFString *stringValue = self.stringValue;
    GTKJustification justify = self.justify;
    bool selectable = self.selectable;
    _multiline = multiline;
    [GTKApp.dispatch.gtk sync: ^{
        gtk_widget_destroy(self.mainWidget);
        gtk_widget_destroy(_scrollWindow);
        _scrollWindow = gtk_scrolled_window_new(NULL, NULL);
        g_object_ref(G_OBJECT(_scrollWindow));
        gtk_widget_show(_scrollWindow);
        GtkStyleContext *context = gtk_widget_get_style_context(_scrollWindow);
        gtk_style_context_add_class(context, "gtkkit-textview");
        if (_editable == true) {
            if (_multiline == true) {
                self.mainWidget = gtk_text_view_new();
                gtk_text_view_set_border_window_size(
                    GTK_TEXT_VIEW(self.mainWidget),
                    GTK_TEXT_WINDOW_TOP,
                    8);
                gtk_text_view_set_border_window_size(
                    GTK_TEXT_VIEW(self.mainWidget),
                    GTK_TEXT_WINDOW_BOTTOM,
                    8);
                gtk_text_view_set_border_window_size(
                    GTK_TEXT_VIEW(self.mainWidget),
                    GTK_TEXT_WINDOW_LEFT,
                    8);
                gtk_text_view_set_border_window_size(
                    GTK_TEXT_VIEW(self.mainWidget),
                    GTK_TEXT_WINDOW_RIGHT,
                    8);
                g_signal_connect(
                    G_OBJECT(self.mainWidget),
                    "focus-out-event",
                    G_CALLBACK(text_view_focus_out_handler),
                    (__bridge gpointer)(self));
                gtk_container_add(
                    GTK_CONTAINER(_scrollWindow),
                    self.mainWidget);
                gtk_widget_show(self.mainWidget);
                gtk_container_add(GTK_CONTAINER(self.overlayWidget), _scrollWindow);
            } else {
                self.mainWidget = gtk_entry_new();
                g_signal_connect(
                    G_OBJECT(self.mainWidget),
                    "activate",
                    G_CALLBACK(entry_activated_handler),
                    (__bridge gpointer)(self));
                g_signal_connect(
                    G_OBJECT(self.mainWidget),
                    "insert-at-cursor",
                    G_CALLBACK(entry_insert_at_cursor_handler),
                    (__bridge gpointer)(self));
                gtk_widget_show(self.mainWidget);
                gtk_container_add(GTK_CONTAINER(self.overlayWidget), self.mainWidget);
            }
        } else {
            self.mainWidget = gtk_label_new(NULL);
            gtk_widget_show(self.mainWidget);
            gtk_container_add(GTK_CONTAINER(self.overlayWidget), self.mainWidget);
        }
    }];
    self.selectable = selectable;
    self.justify = justify;
    self.stringValue = stringValue;
    self.alpha = alpha;
    [self reconnectSignals];
}
@end
