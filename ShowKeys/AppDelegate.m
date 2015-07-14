//
//  AppDelegate.m
//  ShowKeys
//
//  Created by John Hobbs on 6/23/15.
//  Copyright (c) 2015 John Hobbs. All rights reserved.
//

#import "AppDelegate.h"
#import "ShowKeysWindow.h"
#import "ShowKeysWindowController.h"
#import "ConfigurationManager.h"
#import "PreferencesWindowController.h"
#import "Key.h"

@interface AppDelegate ()

@property (weak) IBOutlet ShowKeysWindow *window;
@property (strong, nonatomic) ShowKeysWindowController *windowController;
@property (strong, nonatomic) PreferencesWindowController *prefsWindow;

- (IBAction)preferencesLaunch:(id)sender;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

    [[ConfigurationManager instance] load];
    
    _windowController = [[ShowKeysWindowController alloc] initWithWindow:self.window];

    NSDictionary *options = @{(__bridge id)kAXTrustedCheckOptionPrompt: @YES};
    AXIsProcessTrustedWithOptions((__bridge CFDictionaryRef)options);

    self.prefsWindow = [[PreferencesWindowController alloc]
                        initWithWindowNibName:@"PreferencesWindowController"];
    
    [NSEvent addGlobalMonitorForEventsMatchingMask:NSKeyDownMask
                                           handler:^(NSEvent *event){
                                               [self.windowController appendKey:[[Key alloc] initWithEvent:event]];
                                           }];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    [[ConfigurationManager instance] store];
}

- (IBAction)preferencesLaunch:(id)sender {
    [self.prefsWindow.window makeKeyAndOrderFront:nil];
}

@end