//
//  AppDelegate.m
//  ITPathbar
//
//  Created by Ilija Tovilo on 07/12/14.
//  Copyright (c) 2014 Ilija Tovilo. All rights reserved.
//

#import "AppDelegate.h"
#import "ITPathbar.h"

@interface AppDelegate ()
@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet ITPathbar *pathbar;
@property (weak) IBOutlet NSTextField *titleTextField;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self.pathbar addPathbarComponentWithTitle:@"Hello"];
    [self.pathbar addPathbarComponentWithTitle:@"world"];
    [self.pathbar addPathbarComponentWithTitle:@"Foo"];
    [self.pathbar addPathbarComponentWithTitle:@"Bar"];
    [self.pathbar addPathbarComponentWithTitle:@"This"];
    [self.pathbar addPathbarComponentWithTitle:@"is"];
    [self.pathbar addPathbarComponentWithTitle:@"a"];
    [self.pathbar addPathbarComponentWithTitle:@"pretty"];
    [self.pathbar addPathbarComponentWithTitle:@"decent"];
    [self.pathbar addPathbarComponentWithTitle:@"test"];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)addPathbarComponent:(id)sender {
    [self.pathbar addPathbarComponentWithTitle:self.titleTextField.stringValue];
}

- (IBAction)removeLastPathbarComponent:(id)sender {
    [self.pathbar removeLastPathbarComponent];
}

@end
