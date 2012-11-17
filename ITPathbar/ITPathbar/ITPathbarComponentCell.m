//
//  ITPathbarComponentCell.m
//  ITPathbar
//
//  Created by Ilija Tovilo on 11/13/12.
//  Copyright (c) 2012 Ilija Tovilo. All rights reserved.
//

#import "ITPathbarComponentCell.h"

@implementation ITPathbarComponentCell

- (void)drawFocusRingMaskWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
}

- (BOOL)isLastItem {
    return [[self valueForKey:@"_isLastItem"] boolValue];
}

- (BOOL)isFirstItem {
    return [[self valueForKey:@"_isFirstItem"] boolValue];
}

- (BOOL)isHighlighted {
    if ([self isLastItem]) {
        return YES;
    }
    
    return [super isHighlighted];
}

- (double)_overlapAmount {
    return 12;
}

- (void)drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
    if (self.isHighlighted) {
        [self setTextColor:[NSColor whiteColor]];
    } else {
        [self setTextColor:[NSColor blackColor]];
    }
    
    [NSGraphicsContext saveGraphicsState];
    {
        NSShadow *shadow = [NSShadow new];
        
        if ([self isHighlighted]) {
            [shadow setShadowBlurRadius:1.0];
            [shadow setShadowOffset:NSMakeSize(0, -1)];
            [shadow setShadowColor:[NSColor blackColor]];
        } else {
            [shadow setShadowBlurRadius:0.0];
            [shadow setShadowOffset:NSMakeSize(0, -1)];
            [shadow setShadowColor:[NSColor whiteColor]];
        }
        
        [shadow set];
        
        [super drawInteriorWithFrame:cellFrame inView:controlView];
    }
    [NSGraphicsContext restoreGraphicsState];
}

- (NSRect)titleRectForBounds:(NSRect)theRect {
    NSRect titleFrame = [super titleRectForBounds:theRect];
    NSSize titleSize = [[self attributedStringValue] size];
    titleFrame.origin.y = theRect.origin.y + (theRect.size.height - titleSize.height) / 2.0;
    return titleFrame;
}

- (void)_drawNavigationBarBackgroundWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {    
    NSImage *backgroundImage;
    NSImage *leftArrow;
    NSImage *rightArrow;
    
    if (self.isHighlighted) {
        backgroundImage = [NSImage imageNamed:@"ITPathbar-highlight"];
        
        if (![self isFirstItem]) {
            leftArrow = [NSImage imageNamed:@"ITPathbar-highlight-arrow-left"];
        }
        
        if ([self isLastItem]) {
            rightArrow = [NSImage imageNamed:@"ITPathbar-highlight-edge"];
        } else {
            rightArrow = [NSImage imageNamed:@"ITPathbar-highlight-arrow-right"];
        }
    } else {
        if ([self isLastItem]) {
            rightArrow = [NSImage imageNamed:@"ITPathbar-edge"];
        } else {
            rightArrow = [NSImage imageNamed:@"ITPathbar-separator"];
        }
    }
    
    NSRect backgroundImageFrame = NSMakeRect(
                                             cellFrame.origin.x + leftArrow.size.width,
                                             0,
                                             cellFrame.size.width - leftArrow.size.width - rightArrow.size.width,
                                             cellFrame.size.height);
    
    [backgroundImage drawInRect:backgroundImageFrame
                       fromRect:NSZeroRect operation:NSCompositeSourceOver
                       fraction:1.0
                 respectFlipped:YES hints:nil];
    
    NSRect leftArrowRect = NSMakeRect(cellFrame.origin.x, 0, leftArrow.size.width, cellFrame.size.height);
    [leftArrow drawInRect:leftArrowRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0 respectFlipped:YES hints:nil];
    
    NSRect rightArrowRect = NSMakeRect(cellFrame.origin.x + cellFrame.size.width - rightArrow.size.width, 0, rightArrow.size.width, cellFrame.size.height);
    [rightArrow drawInRect:rightArrowRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0 respectFlipped:YES hints:nil];
}

@end
