//
//  ITPathCell.m
//  ITPathbar
//
//  Created by Ilija Tovilo on 11/13/12.
//  Copyright (c) 2012 Ilija Tovilo. All rights reserved.
//

#import "ITPathbarCell.h"

@implementation ITPathbarCell

+ (Class)pathComponentCellClass {
    return [ITPathbarComponentCell class];
}

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
    NSImage *background = [NSImage imageNamed:@"ITPathbar-fill"];
    [background drawInRect:cellFrame fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0 respectFlipped:YES hints:NO];
    
    [super drawWithFrame:cellFrame inView:controlView];
}

@end
