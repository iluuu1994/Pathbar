//
//  ITPathbar.m
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

#import "ITPathbar.h"

@implementation ITPathbar

+ (Class)cellClass {
    return [ITPathbarCell class];
}

- (void)pinHeight {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1.0f
                                                      constant:self.frame.size.height]];
}

- (void)awakeFromNib {
    [self pinHeight];
    [self setPathStyle:NSPathStyleNavigationBar];
    [self setFocusRingType:NSFocusRingTypeNone];
}

- (NSMutableArray *)mutablePathComponentCells {
    return [self.pathComponentCells mutableCopy];
}

- (void)addItemWithTitle:(NSString *)title {
    [self insertItemWithTitle:title atIndex:self.pathComponentCells.count];
}

- (void)insertItemWithTitle:(NSString *)title atIndex:(NSInteger)index {
    NSMutableArray *cells = [self mutablePathComponentCells];
    ITPathbarComponentCell *cell = [[ITPathbarComponentCell alloc] initTextCell:title];
    
    [cells insertObject:cell atIndex:index];
    
    self.pathComponentCells = cells;
}

- (void)removeItemAtIndex:(NSInteger)index {
    NSMutableArray *cells = [self mutablePathComponentCells];
    [cells removeObjectAtIndex:index];
    
    self.pathComponentCells = cells;
}

- (void)removeLastItem {
    [self removeItemAtIndex:(self.pathComponentCells.count - 1)];
}

- (NSSize)intrinsicContentSize {
    return NSMakeSize(NSViewNoInstrinsicMetric, NSViewNoInstrinsicMetric);
}

@end
