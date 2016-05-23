#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKContainer.h"
#import "GTKWindow.h"
#import "GTKWindow+Actions.h"

@implementation GTKWindow (Actions)
- (void)present
{
	gtk_window_present(GTK_WINDOW(self.widget));
}

- (bool)activateDefaultWidget
{
	return gtk_window_activate_default(GTK_WINDOW(self.widget));
}

- (bool)activateFocusedWidget
{
	return gtk_window_activate_focus(GTK_WINDOW(self.widget));
}

- (void)close
{
	id <GTKWindowDelegate> delegate = self.delegate;

	if ([delegate respondsToSelector: @selector(windowShouldClose:)] &&
	    [delegate windowShouldClose: self]) {
		if ([delegate respondsToSelector: @selector(windowWillClose:)])
			[delegate windowWillClose: self];

		gtk_window_close(GTK_WINDOW(self.widget));
	}
}

- (void)minimize
{
	id <GTKWindowDelegate> delegate = self.delegate;

	if ([delegate respondsToSelector: @selector(windowShouldMinimize:)] &&
	    [delegate windowShouldMinimize: self]) {
		if ([delegate respondsToSelector:
		    @selector(windowWillMinimize:)])
			[delegate windowWillMinimize:self];

		gtk_window_iconify(GTK_WINDOW(self.widget));
	}
}

- (void)unminimize
{
	gtk_window_deiconify (GTK_WINDOW (self.widget));
}

- (void)maximize
{
	id <GTKWindowDelegate> delegate = self.delegate;

	if ([delegate respondsToSelector: @selector(windowShouldMaximize:)] &&
	    [delegate windowShouldMaximize: self]) {
		if ([delegate respondsToSelector:
		    @selector(windowWillMaximize:)])
			[delegate windowWillMaximize:self];

		gtk_window_maximize(GTK_WINDOW(self.widget));
	}
}

- (void)unmaximize
{
	gtk_window_maximize(GTK_WINDOW(self.widget));
}

- (void)fullscreen
{
	gtk_window_fullscreen(GTK_WINDOW(self.widget));
}

- (void)unfullscreen
{
	gtk_window_unfullscreen(GTK_WINDOW(self.widget));
}
@end
