//
//  ITAppDelegate.m
//  ITPathbar
//
//  Created by Ilija Tovilo on 11/16/12.
//  Copyright (c) 2012 Ilija Tovilo. All rights reserved.
//

#import "ITAppDelegate.h"

@implementation ITAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self.pathbar setAction:@selector(pathbarAction:)];
    [self.pathbar setTarget:self];
    
    [self.pathbar addItemWithTitle:@"Copyright"];
    [self.pathbar addItemWithTitle:@"©"];
    [self.pathbar addItemWithTitle:@"2012"];
    [self.pathbar addItemWithTitle:@"by"];
    [self.pathbar addItemWithTitle:@"Ilija Tovilo"];
}


- (IBAction)add:(id)sender {
    [self.pathbar addItemWithTitle:self.pathbarItemName.stringValue];
}

- (IBAction)remove:(id)sender {
    [self.pathbar removeLastItem];
}

- (IBAction)pathbarAction:(id)sender {
    NSLog(@"%@ clicked", [(ITPathbar *)sender clickedPathComponentCell]);
}

@end
