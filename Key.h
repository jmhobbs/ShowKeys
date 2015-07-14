//
//  Key.h
//  ShowKeys
//
//  Created by John Hobbs on 7/1/15.
//  Copyright (c) 2015 John Hobbs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface Key : NSObject

- (id)initWithEvent:(NSEvent *)event;
- (id)initWithTest;

@property (readonly) BOOL wipeBefore;
@property (readonly) BOOL wipeAfter;

- (NSInteger)length;
- (NSString *)stringValue;

@end
