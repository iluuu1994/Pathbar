//
//  ITPathbarComponentCell.m
//  ITPathbar
//
//  Created by Ilija Tovilo on 11/13/12.
//  Copyright (c) 2012 Ilija Tovilo. All rights reserved.
//

// Copyright (c) 2012, Ilija Tovilo
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
//
// Redistributions of source code must retain the above copyright notice,
// this list of conditions and the following disclaimer.
//
// Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation and/or
// other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
// IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
// INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
// PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
// HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
// EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "ITPathbarComponentCell.h"
#import "ITPathbar.h"

@implementation ITPathbarComponentCell

- (void)drawFocusRingMaskWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
}

- (BOOL)isLastItem {
    return [[self valueForKey:@"_isLastItem"] boolValue];
}

- (BOOL)isFirstItem {
    return [[self valueForKey:@"_isFirstItem"] boolValue];
}
/*
 * Lion workaround
- (BOOL)isLastItem {
    NSArray *cells = [(ITPathbar *)[self controlView] pathComponentCells];
    return ([cells lastObject] == self);
}

- (BOOL)isFirstItem {
    NSArray *cells = [(ITPathbar *)[self controlView] pathComponentCells];
    return (cells[0] == self);
}*/

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
