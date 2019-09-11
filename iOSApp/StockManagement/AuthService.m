//
//  AuthService.m
//  StockManagement
//
//  Created by Guillaume Rager on 04/30/2019.
//  Copyright © 2019 CAST. All rights reserved.
//

#import "AuthService.h"

@implementation AuthService

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
        
    return sharedInstance;
}

- (BOOL) isAuthenticated
{
    return (self.session != nil);
}

@end
