//
//  ITPathbarComponent.m
//  ITPathbar
//
//  Created by Ilija Tovilo on 07/12/14.
//  Copyright (c) 2014 Ilija Tovilo. All rights reserved.
//

#import "ITPathbarComponent.h"
#import "ITPathbar.h"
#import "ITPathbarComponentBackgroundView.h"

#define kSeparatorWidth 4.0

@interface ITNonVibrantTextField : NSTextField
@end
@implementation ITNonVibrantTextField
- (BOOL)allowsVibrancy {
    return NO;
}
@end

@interface ITPathbarComponent ()
/// Indicates if the component is currently being clicked
@property (nonatomic, setter=setClicked:) BOOL isClicked;
/// The label for the title
@property (strong) NSTextField *titleLabel;
/// The view that draws the background
@property (strong) ITPathbarComponentBackgroundView *backgroundView;
/// The margin of the title label
@property NSEdgeInsets titleEdgeInsets;
/// The offset of the title label
@property NSPoint titleOffset;
/// A reference back to the pathbar
@property (nonatomic, weak) ITPathbar *pathbar;
@end


@implementation ITPathbarComponent

/// Designated initializer
- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [super initWithFrame:NSZeroRect]) {
        [self initUI];
        self.title = title;
        self.textColor = [NSColor labelColor];
        self.highlightedTextColor = [NSColor whiteColor];
        self.titleEdgeInsets = (NSEdgeInsets){ 0, 2, 0, 2 };
        self.titleOffset = (NSPoint){ 1, 1 };
        self.highlightColor = [NSColor colorWithRed:23.0/255.0 green:126.0/255.0 blue:215.0/255.0 alpha:1.0];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(viewDidResize)
                                                     name:NSViewFrameDidChangeNotification
                                                   object:self];
    }
    return self;
}

/// Deinitializer
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/// Instantiates all the UI elements
- (void)initUI {
    self.minimumSize = NSMakeSize(20, 20);
    
    self.backgroundView = [[ITPathbarComponentBackgroundView alloc] initWithPathbarComponent:self];
    [self.backgroundView setFrame:self.bounds];
    self.backgroundView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    [self addSubview:self.backgroundView];
    
    self.titleLabel = [[ITNonVibrantTextField alloc] initWithFrame:NSZeroRect];
    [self.titleLabel setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    [self.titleLabel setFont:[NSFont systemFontOfSize:14]];
    [self.titleLabel setBezeled:NO];
    [self.titleLabel setDrawsBackground:NO];
    [self.titleLabel setEditable:NO];
    [self.titleLabel setSelectable:NO];
    [self.titleLabel setLineBreakMode:NSLineBreakByCharWrapping];
    [self addSubview:self.titleLabel];
}

/// Updates all UI elements depending on the current state
- (void)updateUI {
    self.titleLabel.textColor = (!self.isHighlighted ? self.textColor : self.highlightedTextColor) ?: [NSColor blackColor];
    self.titleLabel.font = (!self.isHighlighted ? self.font : self.highlightedFont) ?: [NSFont systemFontOfSize:14.0];
    [self.backgroundView setDrawsBackground:self.isHighlighted];
}

/// Layout the pathbar component
- (void)viewDidResize {
    
}

- (void)setFrame:(NSRect)frame {
    [super setFrame:frame];
    [self updateLayout];
}

/// Updates the layout of the sub-elements
- (void)updateLayout {
    NSRect frame = [self frame];
    float labelHeight = self.titleLabel.fittingSize.height - self.titleEdgeInsets.top - self.titleEdgeInsets.bottom;
    self.titleLabel.frame = (NSRect){
        .origin.x = self.titleOffset.x + self.titleEdgeInsets.left + (!self.isFirstComponent ? kSeparatorWidth : 0),
        .origin.y = self.titleOffset.y + NSHeight(frame)/2.0 - labelHeight/2.0,
        .size.width = NSWidth(frame) - self.titleEdgeInsets.left - self.titleEdgeInsets.right,
        .size.height = labelHeight,
    };
}

/// Calculates the optimal size for the pathbar component
- (NSSize)fittingSize {
    
    // Calculate the insets of the text
    NSSize insets = {
        self.titleEdgeInsets.left + self.titleEdgeInsets.right,
        self.titleEdgeInsets.top + self.titleEdgeInsets.bottom,
    };
    
    // Calculate the insets due to the separator
    if (!self.isFirstComponent) insets.width += kSeparatorWidth;
    if (!self.isLastComponent) insets.width += kSeparatorWidth;
    
    return (NSSize){
        .width = self.titleLabel.fittingSize.width + insets.width,
        .height = self.titleLabel.fittingSize.height + insets.height,
    };
}

/// Updates the string value of the title label
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.stringValue = title;
}
/// The color of the text
- (void)setTextColor:(NSColor *)textColor {
    _textColor = textColor;
    [self updateUI];
}

/// The font of the text
- (void)setFont:(NSFont *)font {
    _font = font;
    self.titleLabel.font = font;
}
/// The font of the text when the pathbar component is highlighted
- (void)setHighlightedFont:(NSFont *)highlightedFont {
    _highlightedFont = highlightedFont;
    [self updateUI];
}

/// The color of the text when the pathbar component is highlighted
- (void)setHighlightedTextColor:(NSColor *)highlightedTextColor {
    _highlightedTextColor = highlightedTextColor;
    [self updateUI];
}

/// The color of the highlight
- (void)setHighlightColor:(NSColor *)highlightColor {
    _highlightColor = highlightColor;
    [self updateUI];
}

/// Indicates if the components renders as highlighted
- (BOOL)isHighlighted {
    return self.isClicked || self.isSelected;
}

/// Invoked on mouse down
- (void)mouseDown:(NSEvent *)theEvent {
    self.isClicked = YES;
}

/// Invoked on mouse up
- (void)mouseUp:(NSEvent *)theEvent {
    self.isClicked = NO;
}

/// Indicates if the components is selected
- (void)setClicked:(BOOL)isClicked {
    _isClicked = isClicked;
    [self updateUI];
}

/// Sets the state to selected or not selected
- (void)setSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    [self updateUI];
}

/// Indicates if the component is positioned first in the pathbar
- (BOOL)isFirstComponent {
    return [self.pathbar isFirstComponent:self];
}

/// Indicates if the component is positioned last in the pathbar
- (BOOL)isLastComponent {
    return [self.pathbar isLastComponent:self];
}


// MARK: Helpers

- (ITPathbar *)pathbar {
    return (ITPathbar *)self.superview;
}

- (BOOL)nextComponentIsHighlighted {
    NSUInteger index = [self.pathbar indexOfComponent:self] + 1;
    return [self.pathbar componentAtIndex:index].isHighlighted;
}

@end
