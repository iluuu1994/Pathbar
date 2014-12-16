//
//  ITPathbarComponentBackgroundView.h
//  ITPathbar
//
//  Created by Ilija Tovilo on 13/12/14.
//  Copyright (c) 2014 Ilija Tovilo. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class ITPathbarComponent;

@interface ITPathbarComponentBackgroundView : NSView
/// Designated initializer
- (instancetype)initWithPathbarComponent:(ITPathbarComponent *)pathbarComponent;
/// Indicates if the background is drawn or not
@property (nonatomic) BOOL drawsBackground;
@end
