//
//  NSData+Inflate.h
//  Autoingestion
//
//  Created by idz on 3/13/13.
//  Copyright (c) 2013 idz. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* const IDZZLibErrorDomain;

@interface NSData (IDZGunzip)

- (NSData*)gunzip:(NSError**)error;

@end
