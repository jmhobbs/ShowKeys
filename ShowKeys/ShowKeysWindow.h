//
//  ShowKeysWindow.h
//  ShowKeys
//
//  Created by John Hobbs on 6/24/15.
//  Copyright (c) 2015 John Hobbs. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ShowKeysWindow : NSWindow

@property (weak) IBOutlet NSTextField *keysDisplay;

- (void)configure:(float)opacity textColor:(NSColor *)color;
- (void)setKeys:(NSString *)keys wipe:(bool)wipe;

@end
