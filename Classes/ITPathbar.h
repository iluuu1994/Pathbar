//
//  ITPathbar.h
//  ITPathbar
//
//  Created by Ilija Tovilo on 07/12/14.
//  Copyright (c) 2014 Ilija Tovilo. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class ITPathbarComponent;

@interface ITPathbar : NSView

/// Sets the background color of the pathbar
@property (nonatomic, strong) NSColor *backgroundColor;
/// Sets the color of the bottom separator
@property (nonatomic, strong) NSColor *bottomSeparatorColor;

/// Returns the pathbar component at a given index
- (ITPathbarComponent *)componentAtIndex:(NSUInteger)index;
/// Returns the index of a given component
- (NSUInteger)indexOfComponent:(ITPathbarComponent *)component;
/// Adds a pathbar component with a specific title
- (void)addPathbarComponentWithTitle:(NSString *)title;
/// Removes a pathbar component at a specific index
- (void)removePathbarComponentAtIndex:(NSUInteger)index;
/// Removes the last pathbar component
- (void)removeLastPathbarComponent;

/// Checks if a pathbar component is the first component
- (BOOL)isFirstComponent:(ITPathbarComponent *)component;
/// Checks if a pathbar component is the last component
- (BOOL)isLastComponent:(ITPathbarComponent *)component;

@end
