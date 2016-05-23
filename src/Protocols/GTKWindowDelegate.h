@class GTKWindow;

@protocol GTKWindowDelegate <OFObject>

@optional

// This will be sent to the delegate when the window is told to close; if it
// returns true, the window will close, otherwise it will not.
- (bool)windowShouldClose: (GTKWindow *)sender;

// This will be sent to the delegate when it has been determined that the
// window should close, just before the actual closing is done.
- (void)windowWillClose: (GTKWindow *)sender;

// This will be sent to the delegate when the window has actually been closed.
- (void)windowDidClose: (GTKWindow *)sender;

// This will be sent to the delegate when the window is sent the minimize
// message, before the actual minimizing happens. If this returns true,
// the minimizing will then happen, otherwise it will not.
- (bool)windowShouldMinimize: (GTKWindow *)sender;

// This will be sent to the delegate when it has been determined that the
// window should be minimized, but before the minimizing actually happens.
- (void)windowWillMinimize: (GTKWindow *)sender;

// This will be sent to the delegate immediately after the window has actually
// been minimized.
- (void)windowDidMinimize: (GTKWindow *)sender;

// This will be sent to the delegate immediately after the window has actually
// been minimized.
- (void)windowDidUnminimize: (GTKWindow *)sender;

// This will be sent to the delegate when the window is sent the maximize
// message, before the actual maximizing happens. If this returns true,
// the maximizing will then happen, otherwise it will not.
- (bool)windowShouldMaximize: (GTKWindow *)sender;

// This will be sent to the delegate when it has been determined that the
// window should be maximized, but before the maximizing actually happens.
- (void)windowWillMaximize: (GTKWindow *)sender;

// This will be sent to the delegate immediately after the window has actually
// been maximized.
- (void)windowDidMaximize: (GTKWindow *)sender;

// This will be sent to the delegate immediately after the window has actually
// been unmaximized.
- (void)windowDidUnmaximize: (GTKWindow *)sender;

// This will be sent to the delegate immediately after the window has actually
// been made fullscreen.
- (void)windowDidFullscreen: (GTKWindow *)sender;

// This will be sent to the delegate immediately after the window has actually
// been made non-fullscreen.
- (void)windowDidUnfullscreen: (GTKWindow *)sender;

// This will be sent to the delegate immediately after the window has actually
// been focused.
- (void)windowDidFocus: (GTKWindow *)sender;

// This will be sent to the delegate immediately after the window has actually
// been unfocused.
- (void)windowDidUnfocus: (GTKWindow *)sender;

@end