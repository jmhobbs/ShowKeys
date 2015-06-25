//
//  ShowKeysWindow.m
//  ShowKeys
//
//  Created by John Hobbs on 6/24/15.
//  Copyright (c) 2015 John Hobbs. All rights reserved.
//

#import "ShowKeysWindow.h"
#import <QuartzCore/QuartzCore.h>


@implementation ShowKeysWindow

NSPoint initialLocation;
NSTimer *timer;

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    [self configure];
    return self;
}

- (id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag {
    self = [super initWithContentRect:contentRect styleMask:aStyle backing:bufferingType defer:flag];
    [self configure];
    return self;
}

- (id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag screen:(NSScreen *)screen {
    self = [super initWithContentRect:contentRect styleMask:aStyle backing:bufferingType defer:flag screen:screen];
    [self configure];
    return self;
}

- (void) configure {
    [self configure:0.8 textColor:[NSColor whiteColor]];
}

- (void)configure:(float)opacity textColor:(NSColor *)color {
    [self setBackgroundColor:[NSColor colorWithCalibratedWhite:0.2 alpha:opacity]];
    [self.keysDisplay setTextColor:color];
    [self setOpaque:NO];
    [self setHasShadow:NO];
    [self setLevel:NSFloatingWindowLevel];
}



-(void)mouseDown:(NSEvent *)theEvent {
    NSRect  windowFrame = [self frame];
    
    initialLocation = [NSEvent mouseLocation];
    initialLocation.x -= windowFrame.origin.x;
    initialLocation.y -= windowFrame.origin.y;
}

- (void)mouseDragged:(NSEvent *)theEvent {
    NSPoint currentLocation;
    NSPoint newOrigin;
    
    NSRect  screenFrame = [[NSScreen mainScreen] frame];
    NSRect  windowFrame = [self frame];
    
    currentLocation = [NSEvent mouseLocation];
    newOrigin.x = currentLocation.x - initialLocation.x;
    newOrigin.y = currentLocation.y - initialLocation.y;
    
    // Don't let window get dragged up under the menu bar
    if( (newOrigin.y+windowFrame.size.height) > (screenFrame.origin.y+screenFrame.size.height) ){
        newOrigin.y=screenFrame.origin.y + (screenFrame.size.height-windowFrame.size.height);
    }
    
    //go ahead and move the window to the new location
    [self setFrameOrigin:newOrigin];
}

- (void)setKeys:(NSString *)keys wipe:(bool)wipe {
    if(wipe || nil == timer || ! timer.valid || [keys isEqualTo:@" "] || [[self.keysDisplay stringValue] isEqualTo:@"↵"]) {
        [self.keysDisplay setStringValue:keys];
    }
    else {
        [self.keysDisplay setStringValue:[[self.keysDisplay stringValue] stringByAppendingString:keys]];
    }
    
    if(timer) {
        [timer invalidate];
    }
    
    [self.keysDisplay setAlphaValue:1.0];

    timer = [NSTimer scheduledTimerWithTimeInterval:0.75
                                             target:self
                                           selector:@selector(timeout:)
                                           userInfo:nil
                                            repeats:NO];
}

- (void)timeout:(NSTimer *)timer {
    [NSAnimationContext beginGrouping]; {
        [[NSAnimationContext currentContext] setDuration:.25];
        [[NSAnimationContext currentContext] setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.keysDisplay.animator setAlphaValue:0.0];
    } [NSAnimationContext endGrouping];
}

@end
