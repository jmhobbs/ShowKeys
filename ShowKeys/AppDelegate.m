//
//  AppDelegate.m
//  ShowKeys
//
//  Created by John Hobbs on 6/23/15.
//  Copyright (c) 2015 John Hobbs. All rights reserved.
//

#import "AppDelegate.h"
#import "ShowKeysWindow.h"
#import "ConfigurationManager.h"

@interface AppDelegate ()

@property (weak) IBOutlet ShowKeysWindow *window;
@property (strong, nonatomic) PreferencesWindowController *prefsWindow;

- (IBAction)preferencesLaunch:(id)sender;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

    [[ConfigurationManager instance] load];
    [self.window configure:[ConfigurationManager instance].opacity textColor:[ConfigurationManager instance].textColor];
    
    NSDictionary *options = @{(__bridge id)kAXTrustedCheckOptionPrompt: @YES};
    BOOL accessibilityEnabled = AXIsProcessTrustedWithOptions((__bridge CFDictionaryRef)options);
    // TODO: do something with that

    self.prefsWindow = [[PreferencesWindowController alloc] initWithWindowNibName:@"PreferencesWindowController"];
    self.prefsWindow.delegate = self;
    
    NSArray *specialKeys = @[@36, @48, @51, @53, @123, @124, @125, @126];
    
    [NSEvent addGlobalMonitorForEventsMatchingMask:NSKeyDownMask
                                           handler:^(NSEvent *event){
                                               NSMutableString *all = [[NSMutableString alloc] init];
                                               
                                               bool wipe = NO;
                                               
                                               if([event modifierFlags] & NSShiftKeyMask && [specialKeys containsObject:[NSNumber numberWithUnsignedInt:[event keyCode]]]) {
                                                   wipe = YES;
                                                   [all appendString:@"SHIFT+"];
                                               }
                                               if([event modifierFlags] & NSCommandKeyMask) {
                                                   wipe = YES;
                                                   [all appendString:@"⌘+"];
                                               }
                                               if([event modifierFlags] & NSControlKeyMask) {
                                                   wipe = YES;
                                                   [all appendString:@"CTRL+"];
                                               }

                                               switch ([event keyCode]) {
                                                   case 48:
                                                       [all appendString:@" [TAB]"];
                                                       break;
                                                   case 51:
                                                       [all appendString:@"⇤"];
                                                       wipe = YES;
                                                       break;
                                                   case 53:
                                                       [all appendString:@"ESC"];
                                                       break;
                                                   case 36:
                                                       wipe = YES;
                                                       [all appendString:@"↵"];
                                                       break;
                                                   case 126:
                                                       wipe = YES;
                                                       [all appendString:@"⬆"];
                                                       break;
                                                   case 125:
                                                       wipe = YES;
                                                       [all appendString:@"⬇"];
                                                       break;
                                                   case 124:
                                                       wipe = YES;
                                                       [all appendString:@"➡"];
                                                       break;
                                                   case 123:
                                                       wipe = YES;
                                                       [all appendString:@"⬅"];
                                                       break;
                                                   default:
//                                                       NSLog(@"keyCode: %d", [event keyCode]);
                                                       [all appendString:[event charactersIgnoringModifiers]];
                                                       break;
                                               }
                                            
                                               [self.window setKeys:all wipe:wipe];
                                           }];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    [[ConfigurationManager instance] store];
}

- (IBAction)preferencesLaunch:(id)sender {
    [self.prefsWindow.window makeKeyAndOrderFront:nil];
}

- (void)opacityChanged:(float)opacity {
    [ConfigurationManager instance].opacity = opacity;
    self.window.backgroundColor = [NSColor colorWithCalibratedWhite:0.2 alpha:opacity];
    [self.window setKeys:@"--TEST--" wipe:YES];
}

- (void)textColorChanged:(NSColor *)color {
    [ConfigurationManager instance].textColor = color;
    [self.window.keysDisplay setTextColor:color];
    [self.window setKeys:@"--TEST--" wipe:YES];    
}

@end