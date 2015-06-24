//
//  AppDelegate.m
//  ShowKeys
//
//  Created by John Hobbs on 6/23/15.
//  Copyright (c) 2015 John Hobbs. All rights reserved.
//

#import "AppDelegate.h"
#import "ShowKeysWindow.h"

@interface AppDelegate ()

@property (weak) IBOutlet ShowKeysWindow *window;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

    NSDictionary *options = @{(__bridge id)kAXTrustedCheckOptionPrompt: @YES};
    BOOL accessibilityEnabled = AXIsProcessTrustedWithOptions((__bridge CFDictionaryRef)options);
    
    [NSEvent addGlobalMonitorForEventsMatchingMask:NSKeyDownMask
                                           handler:^(NSEvent *event){
                                               NSMutableString *all = [[NSMutableString alloc] init];
                                               
                                               bool wipe = NO;
                                               
                                               
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
                                                       [all appendString:@"TAB"];
                                                       break;
                                                   case 51:
                                                       [all appendString:@"⇤"];
                                                       wipe = YES;
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
    // Insert code here to tear down your application
}

@end