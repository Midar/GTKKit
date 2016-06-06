#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKEntry.h"

@implementation GTKEntry
- init
{
  self = [super init];
  self.widget = gtk_entry_new();
  self.buffer = gtk_entry_buffer_new(NULL, -1);
  gtk_entry_set_buffer (GTK_ENTRY (self.widget), self.buffer);
  return self;
}

- (id)stringValue
{
  return @(gtk_entry_get_text (GTK_ENTRY (self.widget)));
}

- (void)setStringValue:(id)text
{
  @autoreleasepool {
    const char *newStringValue = [text UTF8String];
    gtk_entry_set_text (GTK_ENTRY (self.widget), newStringValue);
  }
}

- (void)setTextVisible:(bool)visible
{
  gtk_entry_set_visibility (GTK_ENTRY (self.widget), visible);
}

- (bool)textVisible
{
  return gtk_entry_get_visibility (GTK_ENTRY (self.widget));
}

- (void)setMaximumLength:(int)max
{
  gtk_entry_set_max_length (GTK_ENTRY (self.widget), max);
}

- (int)maximumLength
{
  return gtk_entry_get_max_length (GTK_ENTRY (self.widget));
}

- (bool)hasFrame
{
  return gtk_entry_get_has_frame (GTK_ENTRY (self.widget));
}

- (void)setHasFrame:(bool)setting
{
  gtk_entry_set_has_frame (GTK_ENTRY (self.widget), setting);
}
@end
