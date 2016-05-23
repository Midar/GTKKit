#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKWindow.h"

static gboolean window_state_event_dispatch(GtkWidget *window, GdkEventWindowState *event, GTKWindow *sender) {
	// Eventually, this callback will determine what kind of event led to a window-state-event
	// being fired, and call the appropriate code to handle it. For now, this is just
	// testing code to figure out the best way to analyze and dispatch the event handling
	// code.
    printf("Window event dispatch callback has been called.\n");
    
	if(event->changed_mask == GDK_WINDOW_STATE_MAXIMIZED){
	    if(event->new_window_state == GDK_WINDOW_STATE_MAXIMIZED) {
            printf("Window has been maximized.\n");
	    } else {
            printf("Window has been unmaximized.\n");
	    }
    }
    
    if(event->changed_mask == GDK_WINDOW_STATE_ICONIFIED) {
        printf("Window has been minimized or unminimized.\n");
	}
	 
	if(event->changed_mask == GDK_WINDOW_STATE_FULLSCREEN) {
        printf("Window has been made fullscreen or non-fullscreen.\n");
	}
	
	return TRUE;
}

@implementation GTKWindow

@synthesize defaultSize=_defaultSize;
@synthesize size=_size;

- (id)createWidget {
	self.widget = gtk_window_new(GTK_WINDOW_TOPLEVEL);
	return self;
}

- (id)init {
	self = [super init];
	g_signal_connect(G_OBJECT (self.widget), "window-state-event", G_CALLBACK (window_state_event_dispatch), (__bridge void*) self);
	return self;
}

- (of_dimension_t)defaultSize {
	return _defaultSize;
}

- (void)setDefaultSize:(of_dimension_t)size {
	_defaultSize = size;
	gtk_window_set_default_size (GTK_WINDOW (self.widget), (int) size.width, (int) size.height);
}

- (of_dimension_t)size {
	return _size;
}

- (void)setSize:(of_dimension_t)size {
	_size = size;
	gtk_window_resize (GTK_WINDOW (self.widget), (int) size.width, (int) size.height);
}

@end
