//
//  GHViewAnimation.m
//
//  From ViewAnimationTest project. (TODO: Find source)
//  Not sure where this is from originally, and I refactored it a bunch.
//  If anyone recognizes this code, let me know.
//

#import "GHViewAnimation.h"


@implementation GHViewAnimation

- (id)initWithContainer:(NSView *)container view:(NSView *)view1 view:(NSView *)view2 {
  self = [super init];
  if (self) {
    container_ = container;
    
    view1_ = [self wrapView:view1 container:container_ hide:NO];    
    view2_ = [self wrapView:view2 container:container_ hide:YES];
    
    toView_ = view2_;
		fromView_ = view1_;

  }
  return self;
}

- (NSView *)wrapView:(NSView *)view container:(NSView *)container hide:(BOOL)hide {
  NSRect rect = [container bounds];
  NSView *tempView = [[NSView alloc] initWithFrame:rect];
  [tempView addSubview:view];
  [tempView setAutoresizingMask:[container autoresizingMask]];
  [container addSubview:tempView];
  rect = [tempView bounds];
  [tempView setHidden:hide];
  [view setFrame:rect];
  return [tempView autorelease];
}

- (void)prepareSubviewOfView:(NSView *)view {
	NSView *subview = [[view subviews] objectAtIndex:0];
	[subview setFrameOrigin:NSZeroPoint];
	// Reset the mask and let each animation turn on whatever resizing options it needs
	[subview setAutoresizingMask:NSViewNotSizable];
}

- (void)resetSubviewOfView:(NSView *)view {
	NSView *subview = [[view subviews] objectAtIndex:0];
	[subview setFrameOrigin:NSZeroPoint];
	// Allow the views to resize properly now that the animation is done.
	[subview setAutoresizingMask:[container_ autoresizingMask]];
}

- (NSViewAnimation *)dissolve {
  [toView_ setFrame:[container_ bounds]];
  // Note: view does not need to be unhidden manually as in the other cases. This is because the fade in
	// effect will do it for you.

	NSViewAnimation	*animation = [[[NSViewAnimation alloc] initWithViewAnimations:
    [NSArray arrayWithObjects:
      // Old view is set to fade out
			[NSDictionary dictionaryWithObjectsAndKeys:fromView_, NSViewAnimationTargetKey, NSViewAnimationFadeOutEffect, NSViewAnimationEffectKey, nil],
			// New view is set to fade in
			[NSDictionary dictionaryWithObjectsAndKeys:toView_, NSViewAnimationTargetKey, NSViewAnimationFadeInEffect, NSViewAnimationEffectKey, nil],
    nil]
  ] autorelease];
  return animation;
}

- (NSViewAnimation *)moveIn {
  NSRect rect = [container_ bounds];
  // Set the old view to be resizable on the right side. It will appear as if it's sitting still
  [(NSView *)[[fromView_ subviews] objectAtIndex:0] setAutoresizingMask:NSViewMaxXMargin];
			
	// Set the new view to be out of bounds on the right side, ready to be animated in
	[toView_ setFrame:NSMakeRect(NSMaxX(rect), NSMinY(rect), NSWidth(rect), NSHeight(rect))];
	// If a previous animation resulted in a zero frame, it set it to hidden. We have to unhide it manually.
	[toView_ setHidden:NO];
			
	NSViewAnimation *animation = [[[NSViewAnimation alloc] initWithViewAnimations:
    [NSArray arrayWithObjects:
      // The left "viewport" shrinks to zero-width on the left side
			[NSDictionary dictionaryWithObjectsAndKeys:fromView_, NSViewAnimationTargetKey, [NSValue valueWithRect:NSMakeRect(NSMinX(rect), NSMinY(rect), 0.0, NSHeight(rect))], NSViewAnimationEndFrameKey, nil],
      // New view frame is just the viewable area. Since it is currently out of bounds, it will appear to slide
			// in bounds.
			[NSDictionary dictionaryWithObjectsAndKeys:toView_, NSViewAnimationTargetKey, [NSValue valueWithRect:rect], NSViewAnimationEndFrameKey, nil], 
    nil]
  ] autorelease];
  return animation;
}

- (NSViewAnimation *)push {
  NSRect rect = [container_ bounds];
  // Set old view to be resizable on the left side. It will appear to move to the left since the right margin is
	// fixed.
	[(NSView *)[[fromView_ subviews] objectAtIndex:0] setAutoresizingMask:NSViewMinXMargin];			
			
	// Set the new view to be out of bounds on the right side, ready to be animated in			
	[toView_ setFrame:NSMakeRect(NSMaxX(rect), NSMinY(rect), NSWidth(rect), NSHeight(rect))];
	// If a previous animation resulted in a zero frame, it set it to hidden. We have to unhide it manually.
	[toView_ setHidden:NO];
			
	NSViewAnimation *animation = [[[NSViewAnimation alloc] initWithViewAnimations:
    [NSArray arrayWithObjects:
    // Old view frame gets moved to the left, out of bounds.
      [NSDictionary dictionaryWithObjectsAndKeys:fromView_, NSViewAnimationTargetKey, [NSValue valueWithRect:NSMakeRect(NSMinX(rect) - NSWidth(rect), NSMinY(rect), NSWidth(rect), NSHeight(rect))], NSViewAnimationEndFrameKey, nil],
      // New view frame is just the viewable area. Since it is currently out of bounds, it will appear to slide
      // in bounds. Note, this is the same as in the "Move In" case.
      [NSDictionary dictionaryWithObjectsAndKeys:toView_, NSViewAnimationTargetKey, [NSValue valueWithRect:rect], NSViewAnimationEndFrameKey, nil], 
    nil]
  ] autorelease];
  return animation;
}
 
- (NSViewAnimation *)reveal {
  NSRect rect = [container_ bounds];
  // Set old view to be resizable on the left side. It will appear to move to the left since the right margin is
	// fixed.
	[(NSView *)[[fromView_ subviews] objectAtIndex:0] setAutoresizingMask:NSViewMinXMargin];
			
	// Set new view to be resizable on the right side. It will appear to sit still.
	[(NSView *)[[toView_ subviews] objectAtIndex:0] setAutoresizingMask:NSViewMinXMargin];
			
	// Make the right viewport zero-width view on the right side. It will reveal the view as it expands to the left.
	[toView_ setFrame:NSMakeRect(NSMaxX(rect), NSMinY(rect), 0.0, NSHeight(rect))];
	[toView_ setHidden:NO];
			
	// Make the subview such that it's right edge is flush with its superview/viewport.
	[[[toView_ subviews] objectAtIndex:0] setFrame:NSMakeRect(NSMinX(rect) - NSWidth(rect), NSMinY(rect), NSWidth(rect), NSHeight(rect))];
			
  NSViewAnimation *animation = [[[NSViewAnimation alloc] initWithViewAnimations:
    [NSArray arrayWithObjects:
      // The left "viewport" shrinks to zero-width
			[NSDictionary dictionaryWithObjectsAndKeys:fromView_, NSViewAnimationTargetKey,	[NSValue valueWithRect:NSMakeRect(NSMinX(rect), NSMinY(rect), 0.0, NSHeight(rect))], NSViewAnimationEndFrameKey, nil],
					// The right view port expands to encompass the full bounds.
			[NSDictionary dictionaryWithObjectsAndKeys:toView_, NSViewAnimationTargetKey, [NSValue valueWithRect:rect], NSViewAnimationEndFrameKey, nil],
    nil]
  ] autorelease];
  return animation;
}

- (NSViewAnimation *)wipe {
  NSRect rect = [container_ bounds];
  // Set the old view to be resizable on the right side. It will appear as if it's sitting still
	[(NSView *)[[fromView_ subviews] objectAtIndex:0] setAutoresizingMask:NSViewMaxXMargin];
			
	// Set new view to be resizable on the right side. It will appear to sit still.
	[(NSView *)[[toView_ subviews] objectAtIndex:0] setAutoresizingMask:NSViewMinXMargin];
			
	// Make the right viewport zero-wdith
	[toView_ setFrame:NSMakeRect(NSMaxX(rect), NSMinY(rect), 0.0, NSHeight(rect))];
	[toView_ setHidden:NO];
			
	// Make the subview such that it's right edge is flush with its superview/viewport.
	[[[toView_ subviews] objectAtIndex:0] setFrame:NSMakeRect(NSMinX(rect) - NSWidth(rect), NSMinY(rect), NSWidth(rect), NSHeight(rect))];

	NSViewAnimation *animation = [[[NSViewAnimation alloc] initWithViewAnimations:
    [NSArray arrayWithObjects:
      // The left "viewport" shrinks to zero-width
			[NSDictionary dictionaryWithObjectsAndKeys:fromView_, NSViewAnimationTargetKey,	[NSValue valueWithRect:NSMakeRect(NSMinX(rect), NSMinY(rect), 0.0, NSHeight(rect))], NSViewAnimationEndFrameKey, nil],
			// The right view port expands to encompass the full bounds.
      [NSDictionary dictionaryWithObjectsAndKeys:toView_, NSViewAnimationTargetKey,	[NSValue valueWithRect:rect], NSViewAnimationEndFrameKey, nil],
    nil]
  ] autorelease];
  return animation;
}


- (void)animate:(GHViewAnimationType)animationType {

  if ([view1_ isHidden]) {
		toView_ = view1_;
		fromView_ = view2_;
	} else {
		toView_ = view2_;
		fromView_ = view1_;
	}

  // Unset the first responder. Can cause drawing artifacts since the blue glow extends beyond the view's bounds.
	//[[container_ window] makeFirstResponder:nil];
	
	// Turn off all autoresizing for now. Will be twiddling these for different effects.
	[self prepareSubviewOfView:toView_];
	[self prepareSubviewOfView:fromView_];
  
  NSViewAnimation *animation = nil;
  switch (animationType) {
		case GHViewAnimationDissolve: animation = [self dissolve]; break;
		case GHViewAnimationMoveIn: animation = [self moveIn]; break;
    case GHViewAnimationPush: animation = [self push]; break;
		case GHViewAnimationReveal: animation = [self reveal]; break;
		case GHViewAnimationWipe: animation = [self wipe]; break;
    default:
      NSAssert(false, @"Invalid animation type");
	}
  

  [animation setAnimationBlockingMode:NSAnimationBlocking];
	[animation startAnimation];
	
	// Not all the animations above result in the old view being hidden so do it here
	[fromView_ setHidden:YES];
	
	[self resetSubviewOfView:fromView_];
	[self resetSubviewOfView:toView_];
}

@end
