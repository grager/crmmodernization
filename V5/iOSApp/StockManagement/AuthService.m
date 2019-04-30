//
//  AuthService.m
//  StockManagement
//
//  Created by Guillaume Rager on 04/30/2019.
//  Copyright © 2019 CAST. All rights reserved.
//

#import "AuthService.h"
#import "Jwt.h"

@implementation AuthService

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newTokenReceived:) name:@"SigninCompleted" object:nil];
    
    return sharedInstance;
}

- (BOOL) isAuthenticated
{
    NSError *error;
    
    if([Jwt decodeWithToken:self.currentJwtToken andKey:@"thekey" andVerify:YES andError:&error])
    {
        if(!error)
        {
            return YES;
        }
        return NO;
    }

    return NO;
}

- (void) newTokenReceived:(NSNotification*)aNotifiction
{
    self.currentJwtToken = aNotifiction.object[@"jwtToken"];
}

@end
