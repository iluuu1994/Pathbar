//
//  ITPathbar.m
//  ITPathbar
//
//  Created by Ilija Tovilo on 11/13/12.
//  Copyright (c) 2012 Ilija Tovilo. All rights reserved.
//

#import "ITPathbar.h"

@implementation ITPathbar

+ (Class)cellClass {
    return [ITPathbarCell class];
}

- (void)awakeFromNib {
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

@end
