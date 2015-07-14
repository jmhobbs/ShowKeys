//
//  ShowKeysWindowController.h
//  ShowKeys
//
//  Created by John Hobbs on 7/1/15.
//  Copyright (c) 2015 John Hobbs. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Key.h"

@interface ShowKeysWindowController : NSWindowController

- (void)appendKey:(Key *)key;

@end
