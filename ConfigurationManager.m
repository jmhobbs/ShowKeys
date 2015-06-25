//
//  ConfigurationManager.m
//  ShowKeys
//
//  Created by John Hobbs on 6/25/15.
//  Copyright (c) 2015 John Hobbs. All rights reserved.
//

#import "ConfigurationManager.h"

static NSString *const kPreferenceOpacity    = @"opacity";
static NSString *const kPrefrenceFadeTimeout = @"fade";
static NSString *const kPreferenceFontSize    = @"fontSize";
static NSString *const kPreferenceTextColor  = @"textColor";

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
    _fadeTimeout = 1.0;
    _fontSize = 32;
    _textColor = [NSColor whiteColor];
}

- (void)load {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    _opacity = [prefs floatForKey:kPreferenceOpacity];
    _fadeTimeout = [prefs floatForKey:kPrefrenceFadeTimeout];

    _fontSize = [prefs integerForKey:kPreferenceFontSize];
    if(_fontSize == 0) {
        _fontSize = 32;
    }
    
    NSData *data = [prefs objectForKey:kPreferenceTextColor];
    if(nil == data) {
        _textColor = [NSColor whiteColor];
    }
    else {
        _textColor = [NSUnarchiver unarchiveObjectWithData:data];
        if(![_textColor isKindOfClass:[NSColor class]]) {
            _textColor = [NSColor whiteColor];
        }
    }
}

- (void)store {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    [prefs setFloat:_opacity forKey:kPreferenceOpacity];
    [prefs setFloat:_fadeTimeout forKey:kPrefrenceFadeTimeout];
    [prefs setInteger:_fontSize forKey:kPreferenceFontSize];
    NSData *data = [NSArchiver archivedDataWithRootObject:_textColor];
    [prefs setObject:data forKey:kPreferenceTextColor];
    [prefs synchronize];
}

@end
