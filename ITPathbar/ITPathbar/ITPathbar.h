//
//  ITPathbar.h
//  ITPathbar
//
//  Created by Ilija Tovilo on 11/13/12.
//  Copyright (c) 2012 Ilija Tovilo. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ITPathbarCell.h"

@protocol ITPathbarDelegate <NSPathControlDelegate>
@end


@interface ITPathbar : NSPathControl

- (void)insertItemWithTitle:(NSString *)title atIndex:(NSInteger)index;
- (void)addItemWithTitle:(NSString *)title;
- (void)removeItemAtIndex:(NSInteger)index;
- (void)removeLastItem;

@end
