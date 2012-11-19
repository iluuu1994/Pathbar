//
//  ITAppDelegate.m
//  ITPathbar
//
//  Created by Ilija Tovilo on 11/16/12.
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
