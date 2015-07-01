//
//  PreferencesWindowController.h
//  ShowKeys
//
//  Created by John Hobbs on 6/24/15.
//  Copyright (c) 2015 John Hobbs. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol PreferencesWindowDelegate <NSObject>

- (void)opacityChanged:(float)opacity;
- (void)fadeTimeoutChanged:(float)timeout;
- (void)fontSizeChanged:(NSInteger)size;
- (void)textColorChanged:(NSColor *)color;
- (void)maxCharsChanged:(NSInteger)chars;

@end

@interface PreferencesWindowController : NSWindowController

@property id<PreferencesWindowDelegate> delegate;

@end
