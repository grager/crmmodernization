//
//  AuthService.h
//  StockManagement
//
//  Created by Guillaume Rager on 04/30/2019.
//  Copyright © 2019 CAST. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AWSCognitoAuth, AWSCognitoAuthUserSession;

@interface AuthService : NSObject
{
}

@property (nonatomic, strong) AWSCognitoAuth * auth;
@property (nonatomic, strong) AWSCognitoAuthUserSession *session;


+ (instancetype)sharedInstance;

- (BOOL) isAuthenticated;

@end
