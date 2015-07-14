//
//  ConfigurationManager.h
//  ShowKeys
//
//  Created by John Hobbs on 6/25/15.
//  Copyright (c) 2015 John Hobbs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

static NSString *const kConfigurationChangedNotification   = @"ConfigurationChangedNotification";

@interface ConfigurationManager : NSObject

@property float opacity;
@property float fadeTimeout;
@property NSInteger fontSize;
@property (strong, nonatomic) NSColor *textColor;
@property NSInteger maxChars;

+ (ConfigurationManager *)instance;

- (void)reset;
- (void)load;
- (void)store;

@end