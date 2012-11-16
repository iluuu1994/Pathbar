//
//  ITAppDelegate.h
//  ITPathbar
//
//  Created by Ilija Tovilo on 11/16/12.
//  Copyright (c) 2012 Ilija Tovilo. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ITPathbar.h"

@interface ITAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet ITPathbar *pathbar;
@property (assign) IBOutlet NSTextField *pathbarItemName;

@end
