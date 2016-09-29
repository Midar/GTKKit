/*

GTKViewController is a parent class for classes which implement "view controllers",
controller objects which manage the content and behavior of a set of views.
Typically, a view controller is responsible for mediating the relationship between
its views and the models they represent, and for implementing the behaviors
of its view hierarchy.

A view controller is intended to be the owner of all of the views it manages;
other instances should use only weak references to refer to those views.

The most common type of view controller would be a GTKWindowViewController, which
implements a desktop-style top-level window.

An important subclass of GTKViewController is GTKContainerViewController, which
implements a view controller which manages a set of view controllers; an example
of a container view controller would be GTKTabbedWindowViewController, which
implements a "tabbed" multi-document interface top-level window, displaying a
single view controller at a time based on which tab is selected.

A content view controller has a GTKView instance assigned to it's "view" property;
this is the view controller's "root view", the base of the view hierarchy managed
by that view controller. A container view controller does not have a "view"
property, it instead has properties for its defined child view controllers.

Not all view controllers manage a top-level window of some kind - some are meant
to manage one complex, reusable part of an application. An example of this would
be the GTKSplitViewController, which implements a view controller that shows
two view hierarchies side-by-side, managing the overall arrangement and sizing of
those view controllers, but leaving them to manage their own contents, and having
its own overall size and position managed by its parent view controller.

Most applications have at least one custom view controller subclass, which
implements the core UI of the application.

View controllers are responder objects, participating in the responder chain as
follows:
  - A content view controller is inserted into the responder chain between its
    root view and that view's superview
  - A container view controller is inserted into the responder chain either
    between its child view controllers and the superviews of their root views,
    or between those child view controllers and *their* child view controllers,
    depending on the type of child the container view controller is managing.


*/



#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>

#import "GTKResponder.h"

@interface GTKViewController: GTKResponder

@end
