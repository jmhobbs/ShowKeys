//
//  ConfigurationManager.m
//  ShowKeys
//
//  Created by John Hobbs on 6/25/15.
//  Copyright (c) 2015 John Hobbs. All rights reserved.
//

#import "ConfigurationManager.h"

static NSString *const kPreferenceOpacity     = @"opacity";
static NSString *const kPreferenceFadeTimeout = @"fade";
static NSString *const kPreferenceFontSize    = @"fontSize";
static NSString *const kPreferenceTextColor   = @"textColor";
static NSString *const kPreferenceMaxChars    = @"maxChars";

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
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:@{
                                                              kPreferenceOpacity: @0.8,
                                                              kPreferenceFadeTimeout: @1.0,
                                                              kPreferenceFontSize: @32,
                                                              kPreferenceMaxChars: @32,
                                                              kPreferenceTextColor: [NSArchiver archivedDataWithRootObject:[NSColor whiteColor]]
                                                              }];
    return self;
}

- (void)reset {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kPreferenceOpacity];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kPreferenceFadeTimeout];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kPreferenceFontSize];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kPreferenceMaxChars];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kPreferenceTextColor];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self load];
}

- (void)load {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    _opacity = [prefs floatForKey:kPreferenceOpacity];
    _fadeTimeout = [prefs floatForKey:kPreferenceFadeTimeout];
    _fontSize = [prefs integerForKey:kPreferenceFontSize];
    _maxChars = [prefs integerForKey:kPreferenceMaxChars];
    
    NSData *data = [prefs objectForKey:kPreferenceTextColor];
    _textColor = [NSUnarchiver unarchiveObjectWithData:data];
}

- (void)store {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    [prefs setFloat:_opacity forKey:kPreferenceOpacity];
    [prefs setFloat:_fadeTimeout forKey:kPreferenceFadeTimeout];
    [prefs setInteger:_fontSize forKey:kPreferenceFontSize];
    NSData *data = [NSArchiver archivedDataWithRootObject:_textColor];
    [prefs setInteger:_maxChars forKey:kPreferenceMaxChars];
    [prefs setObject:data forKey:kPreferenceTextColor];
    [prefs synchronize];
}

@end
