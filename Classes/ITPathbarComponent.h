//
//  ITPathbarComponent.h
//  ITPathbar
//
//  Created by Ilija Tovilo on 07/12/14.
//  Copyright (c) 2014 Ilija Tovilo. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ITPathbarComponent : NSView

/// Designated initializer
- (instancetype)initWithTitle:(NSString *)title;

/// The title displayed in the pathbar component
@property (nonatomic, strong) NSString *title;
/// Indicates if the components renders as highlighted
@property (nonatomic, readonly) BOOL isHighlighted;
/// The color of the text
@property (nonatomic, strong) NSColor *textColor;
/// The color of the text when the pathbar component is highlighted
@property (nonatomic, strong) NSColor *highlightedTextColor;
/// The font of the text
@property (nonatomic, strong) NSFont *font;
/// The font of the text when the pathbar component is highlighted
@property (nonatomic, strong) NSFont *highlightedFont;
/// The color of the highlight
@property (nonatomic, strong) NSColor *highlightColor;
/// Indicates if the components is selected
@property (nonatomic, setter=setSelected:) BOOL isSelected;
/// The minimum size of the pathbar component
@property (nonatomic) NSSize minimumSize;
/// Indicates if the component is positioned first in the pathbar
@property (nonatomic, readonly) BOOL isFirstComponent;
/// Indicates if the component is positioned last in the pathbar
@property (nonatomic, readonly) BOOL isLastComponent;

@end
