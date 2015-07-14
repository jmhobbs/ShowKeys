//
//  Key.m
//  ShowKeys
//
//  Created by John Hobbs on 7/1/15.
//  Copyright (c) 2015 John Hobbs. All rights reserved.
//

#import "Key.h"

@interface Key ()

@property NSString *characters;
@property bool shift;
@property bool command;
@property bool control;
@property bool alt;

@property NSString *representation;

@end

@implementation Key

- (id)init {
    self = [super init];
    
    _wipeBefore = NO;
    _wipeAfter = NO;
    
    return self;
}

- (id)initWithEvent:(NSEvent *)event {
    
    self = [self init];
    
    static NSArray *specialKeys;
    if(! specialKeys) {
        specialKeys = @[@36, @48, @51, @53, @114, @116, @117, @121, @123, @124, @125, @126];
    }
    
    NSMutableString *all = [[NSMutableString alloc] init];

    self.shift = [event modifierFlags] & NSShiftKeyMask;
    self.command = [event modifierFlags] & NSCommandKeyMask;
    self.control = [event modifierFlags] & NSControlKeyMask;
                                               
    if(self.shift && [specialKeys containsObject:[NSNumber numberWithUnsignedInt:[event keyCode]]]) {
        _wipeBefore = YES;
        [all appendString:@"SHIFT+"];
    }
    
    if([event modifierFlags] & NSCommandKeyMask) {
        _wipeBefore = YES;
        [all appendString:@"⌘+"];
    }
    
    if([event modifierFlags] & NSControlKeyMask) {
        _wipeBefore = YES;
        [all appendString:@"CTRL+"];
    }
    
    switch ([event keyCode]) {
        case 36:
            _wipeAfter = YES;
            [all appendString:@"↵"];
            break;
        case 48:
            [all appendString:@"[TAB]"];
            break;
        case 51:
            _wipeAfter = YES;
            [all appendString:@"⇤"];
            break;
        case 53:
            [all appendString:@"[ESC]"];
            break;
        case 114:
            [all appendString:@"[INS]"];
            break;
        case 116:
            _wipeBefore = YES;
            _wipeAfter = YES;
            [all appendString:@"[PGUP]"];
            break;
        case 117:
            _wipeBefore = YES;
            _wipeAfter = YES;
            [all appendString:@"[DEL]"];
            break;
        case 121:
            _wipeBefore = YES;
            _wipeAfter = YES;
            [all appendString:@"[PGDN]"];
            break;
        case 123:
            _wipeBefore = YES;
            _wipeAfter = YES;
            [all appendString:@"⬅"];
            break;
        case 124:
            _wipeBefore = YES;
            _wipeAfter = YES;
            [all appendString:@"➡"];
            break;
        case 125:
            _wipeBefore = YES;
            _wipeAfter = YES;
            [all appendString:@"⬇"];
            break;
        case 126:
            _wipeBefore = YES;
            _wipeAfter = YES;            
            [all appendString:@"⬆"];
            break;
        default:
            [all appendString:[event charactersIgnoringModifiers]];
            break;
    }

    self.representation = all;
    
    return self;
}

- (id)initWithTest {
    self = [self init];
    self.representation = @"== TEST ==";
    return self;
}

- (NSInteger)length {
    return [self.representation length];
}

- (NSString *)stringValue {
    return self.representation;
}

@end
