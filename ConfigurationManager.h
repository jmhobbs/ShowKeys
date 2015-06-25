//
//  ConfigurationManager.h
//  ShowKeys
//
//  Created by John Hobbs on 6/25/15.
//  Copyright (c) 2015 John Hobbs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface ConfigurationManager : NSObject

@property float opacity;
@property (strong, nonatomic) NSColor *textColor;

+ (ConfigurationManager *)instance;

- (void)reset;
- (bool)load;
- (bool)store;

@end