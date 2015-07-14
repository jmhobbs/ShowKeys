//
//  ShowKeysWindowController.m
//  ShowKeys
//
//  Created by John Hobbs on 7/1/15.
//  Copyright (c) 2015 John Hobbs. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ShowKeysWindowController.h"
#import "ShowKeysWindow.h"
#import "ConfigurationManager.h"


@implementation ShowKeysWindowController {
    NSTimer *timer;
    float fadeTimeout;
    NSInteger maxChars;
    ShowKeysWindow *skwindow;
    NSMutableArray *keys;
}

- (id)initWithWindow:(NSWindow *)window {
    self = [super initWithWindow:window];
    
    keys = [[NSMutableArray alloc] init];
    
    // I'm lazy.
    skwindow = (ShowKeysWindow *) self.window;

    [self.window setOpaque:NO];
    [self.window setHasShadow:NO];
    [self.window setLevel:NSFloatingWindowLevel];
    
    [self configurationChanged:nil];
    [skwindow.keysDisplay setNeedsLayout:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(configurationChanged:)
                                                 name:kConfigurationChangedNotification
                                               object:nil];
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) configurationChanged:(NSNotification *) notification {
    [self.window setBackgroundColor:[NSColor colorWithCalibratedWhite:0.2 alpha:[ConfigurationManager instance].opacity]];
    [skwindow.keysDisplay setTextColor:[ConfigurationManager instance].textColor];
    fadeTimeout = [ConfigurationManager instance].fadeTimeout;
    NSFont *font = [NSFont fontWithName:skwindow.keysDisplay.font.fontName size:(float)[ConfigurationManager instance].fontSize];
    [skwindow.keysDisplay setFont:font];
    maxChars = [ConfigurationManager instance].maxChars;
    [keys removeAllObjects];
    [keys addObject:[[Key alloc] initWithTest]];
    [self updateKeysDisplay];
}

- (void)resetWindowWidth {
    NSRect window = [self.window frame];
    window.size.width = 320;  // TODO: Make this width configurable
    [self.window setFrame:window display:YES animate:YES];
}

- (void)appendKey:(Key *)key {
    // Let's see you grok this, sucker.
    if(key.wipeBefore || ([keys count] > 0 && ((Key *)[keys objectAtIndex:[keys count]-1]).wipeAfter)) {
        [keys removeAllObjects];
    }
    [keys addObject:key];
    NSInteger length = 0;
    for (Key *key in keys) {
        length += [key length];
    }
    while(length > maxChars && [keys count] > 1) {
        length -= [keys[0] length];
        [keys removeObjectAtIndex:0];
    }
    [self updateKeysDisplay];
}

- (NSString *)keysAsString {
    NSMutableString *out = [[NSMutableString alloc] init];
    for (Key *key in keys) {
        [out appendString:[key stringValue]];
    }
    return out;
}


- (void)updateKeysDisplay {
    [skwindow.keysDisplay setStringValue:[self keysAsString]];
    [self resetWindowWidth];
    
    if(timer) {
        [timer invalidate];
    }

    [skwindow.keysDisplay setAlphaValue:1.0];
    
    if(fadeTimeout >= 0.25) {
        timer = [NSTimer scheduledTimerWithTimeInterval:fadeTimeout - 0.25
                                                 target:self
                                               selector:@selector(timeout:)
                                               userInfo:nil
                                                repeats:NO];
    }
}

- (void)timeout:(NSTimer *)timer {
    [keys removeAllObjects];
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        [[NSAnimationContext currentContext] setDuration:.25];
        [[NSAnimationContext currentContext] setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [skwindow.keysDisplay.animator setAlphaValue:0.0];
    }
                        completionHandler:^{
                            [self resetWindowWidth];
                        }];
}


@end
