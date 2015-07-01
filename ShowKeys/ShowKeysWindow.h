//
//  ShowKeysWindow.h
//  ShowKeys
//
//  Created by John Hobbs on 6/24/15.
//  Copyright (c) 2015 John Hobbs. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ShowKeysWindow : NSWindow

@property float fadeTimeout;
@property (weak) IBOutlet NSTextField *keysDisplay;
@property NSInteger maxChars;

- (void)configure:(float)opacity
      fadeTimeout:(float)timeout
         fontSize:(NSInteger)size
         maxChars:(NSInteger)maxChars
        textColor:(NSColor *)color;

- (void)setKeys:(NSString *)keys wipe:(bool)wipe;

@end