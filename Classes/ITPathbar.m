//
//  ITPathbar.m
//  ITPathbar
//
//  Created by Ilija Tovilo on 07/12/14.
//  Copyright (c) 2014 Ilija Tovilo. All rights reserved.
//

#import "ITPathbar.h"
#import "ITPathbarComponent.h"
#import "ITPathbarLayer.h"

#define kSeparatorWidth 4.0

@interface ITPathbar ()
/// A collection of all the displayed pathbar components
@property (strong) NSMutableArray *pathbarComponents;
/// Expanded component
@property (nonatomic, weak) ITPathbarComponent *expandedPathbarComponent;
/// The tracking area of the pathbar
@property (nonatomic, strong) NSTrackingArea *trackingArea;
@end

@implementation ITPathbar

/// Initializer from code
- (instancetype)initWithFrame:(NSRect)frameRect {
    if (self = [super initWithFrame:frameRect]) {
        [self commonInit];
    }
    return self;
}

/// Initializer for Interface Builder
- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self commonInit];
    }
    return self;
}

/// Common initializer that is always executed
- (void)commonInit {
    self.wantsLayer = YES;
    self.pathbarComponents = [NSMutableArray array];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(viewDidResize)
                                                 name:NSViewFrameDidChangeNotification
                                               object:self];
}

- (CALayer *)makeBackingLayer {
    return [ITPathbarLayer layer];
}

/// Deinitializer
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/// Sets the background color of the pathbar
- (void)setBackgroundColor:(NSColor *)backgroundColor {
    _backgroundColor = backgroundColor;
    self.layer.backgroundColor = backgroundColor.CGColor;
}

/// Sets the color of the bottom separator
- (void)setBottomSeparatorColor:(NSColor *)bottomSeparatorColor {
    _bottomSeparatorColor = bottomSeparatorColor;
    assert(!"Unimplemented");
}

/// Returns the pathbar component at a given index
- (ITPathbarComponent *)componentAtIndex:(NSUInteger)index {
    if (index >= self.pathbarComponents.count) return nil;
    return self.pathbarComponents[index];
}

/// Returns the index of a given component
- (NSUInteger)indexOfComponent:(ITPathbarComponent *)component {
    return [self.pathbarComponents indexOfObject:component];
}

/// Adds a pathbar component with a specific title
- (void)addPathbarComponentWithTitle:(NSString *)title {
    ITPathbarComponent *component = [[ITPathbarComponent alloc] initWithTitle:title];
    [self addSubview:component];
    [self.pathbarComponents addObject:component];
    [self layoutPathbarComponents:NO];
}

/// Removes a pathbar component at a specific index
- (void)removePathbarComponentAtIndex:(NSUInteger)index {
    // Sanity check
    if (self.pathbarComponents.count < index) return;
    
    [self.pathbarComponents[index] removeFromSuperview];
    [self.pathbarComponents removeObjectAtIndex:index];
    [self layoutPathbarComponents:NO];
}

/// Removes the last pathbar component
- (void)removeLastPathbarComponent {
    [self removePathbarComponentAtIndex:self.pathbarComponents.count - 1];
}

/// Checks if a pathbar component is the first component
- (BOOL)isFirstComponent:(ITPathbarComponent *)component {
    return self.pathbarComponents.firstObject == component;
}
/// Checks if a pathbar component is the last component
- (BOOL)isLastComponent:(ITPathbarComponent *)component {
    return self.pathbarComponents.lastObject == component;
}


// MARK: Layout

/// Called whenever the size of the view changes
- (void)viewDidResize {
    [self layoutPathbarComponents:NO];
}

/// Updates the layout of all path components
- (void)layoutPathbarComponents:(BOOL)animate {
    NSMutableArray *widths = [NSMutableArray arrayWithCapacity:self.pathbarComponents.count];
    
    // Reverse loop over all components
    float spaceAvailable = NSWidth(self.frame);
    for (NSInteger i = self.pathbarComponents.count - 1; i >= 0; i--) {
        ITPathbarComponent *component = self.pathbarComponents[i];
        float width = component.minimumSize.width;
        [widths insertObject:@( width ) atIndex:0];
        spaceAvailable -= width;
        if (!component.isFirstComponent) spaceAvailable += kSeparatorWidth/2.0;
        if (!component.isLastComponent) spaceAvailable += kSeparatorWidth/2.0;
    }
    
    // Increase the components as long as there is space left
    for (NSInteger i = self.pathbarComponents.count - 1; i >= 0; i--) {
        ITPathbarComponent *component = self.pathbarComponents[i];
        float increaseBy = fmin(component.fittingSize.width - [widths[i] floatValue], spaceAvailable);
        widths[i] = @( [widths[i] floatValue] + increaseBy );
        spaceAvailable -= increaseBy;
        if (spaceAvailable <= 0) break;
    }
    
    // Set the fitting size width to the the expanded component
    if (self.expandedPathbarComponent) {
        NSUInteger expandedIndex = [self.pathbarComponents indexOfObject:self.expandedPathbarComponent];
        widths[expandedIndex] = @( self.expandedPathbarComponent.fittingSize.width );
    }
    
    // Loop to update the x position
    [NSAnimationContext beginGrouping];
    [NSAnimationContext.currentContext setDuration:(animate ? 0.5 : 0.0)];
    {
        float xOrigin = 0;
        for (int i = 0; i < self.pathbarComponents.count; i++) {
            ITPathbarComponent *component = self.pathbarComponents[i];
            float width = [widths[i] floatValue];
            
            component.animator.frame = (NSRect) {
                .size.width = width,
                .size.height = NSHeight(self.frame),
                .origin.x = xOrigin,
                .origin.y = 0,
            };
            xOrigin += (width - kSeparatorWidth);
        }
    }
    [NSAnimationContext endGrouping];
}


// MARK: Hit testing

- (void)mouseEntered:(NSEvent *)theEvent {
    [self updateExpansionWithEvent:theEvent];
}

- (void)mouseMoved:(NSEvent *)theEvent {
    [self updateExpansionWithEvent:theEvent];
}

- (void)mouseExited:(NSEvent *)theEvent {
    self.expandedPathbarComponent = nil;
}

- (void)updateExpansionWithEvent:(NSEvent *)event {
    NSPoint point = [self convertPoint:event.locationInWindow fromView:nil];
    id view = [self hoveredView:point];
    
    // Ignore if the view is not a pathbar component
    if ([view isKindOfClass:ITPathbarComponent.class] && self.expandedPathbarComponent != view) {
        self.expandedPathbarComponent = view;
    }
}

- (void)setExpandedPathbarComponent:(ITPathbarComponent *)expandedPathbarComponent {
    // We only update if the expanded component has changed
    if (_expandedPathbarComponent != expandedPathbarComponent) {
        _expandedPathbarComponent = expandedPathbarComponent;
        [self layoutPathbarComponents:YES];
    }
}

- (ITPathbarComponent *)hoveredView:(NSPoint)point {
    for (NSView *subview in self.subviews) {
        // Continue if not pathbar component
        if (![subview isKindOfClass:ITPathbarComponent.class]) continue;
        // Check if point in frame
        if (NSPointInRect(point, [subview.layer.presentationLayer frame]))
            return (ITPathbarComponent *)subview;
    }
    
    return nil;
}


// MARK: Tracking area

- (void)updateTrackingAreas {
    if (!NSEqualRects(self.trackingArea.rect, self.bounds)) {
        [self removeTrackingArea:self.trackingArea];
        self.trackingArea = [[NSTrackingArea alloc] initWithRect:self.bounds
                                                         options:NSTrackingActiveAlways | NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved
                                                           owner:self
                                                        userInfo:nil];
        [self addTrackingArea:self.trackingArea];
    }
}

@end
