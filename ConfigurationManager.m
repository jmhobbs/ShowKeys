//
//  ConfigurationManager.m
//  ShowKeys
//
//  Created by John Hobbs on 6/25/15.
//  Copyright (c) 2015 John Hobbs. All rights reserved.
//

#import "ConfigurationManager.h"

static NSString *const kPreferenceOpacity   = @"opacity";
static NSString *const kPreferenceTextColor = @"textColor";

@implementation ConfigurationManager

+ (ConfigurationManager *)instance {
    static ConfigurationManager *instance;
    if(!instance) {
        instance = [[ConfigurationManager alloc] initInstance];
    }
    return instance;
}

- (instancetype)init { return nil; }

- (instancetype)initInstance {
    self = [super init];
    [self reset];
    return self;
}

- (void)reset {
    _opacity = 0.8;
    _textColor = [NSColor whiteColor];
}

- (bool)load {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    _opacity = [prefs floatForKey:kPreferenceOpacity];
    _textColor = [prefs objectForKey:kPreferenceTextColor];
    
    NSData *data = [prefs objectForKey:kPreferenceTextColor];
    if(nil == data) {
        [self reset];
        return NO;
    }
    
    _textColor = [NSUnarchiver unarchiveObjectWithData:data];
    if(![_textColor isKindOfClass:[NSColor class]]) {
        _textColor = [NSColor whiteColor];
    }
    
    return YES;
}

- (bool)store {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    [prefs setFloat:_opacity forKey:kPreferenceOpacity];
    NSData *data = [NSArchiver archivedDataWithRootObject:_textColor];
    [prefs setObject:data forKey:kPreferenceTextColor];
    [prefs synchronize];
    
    return YES;
}

@end
