//
//  CustomerModel.h
//  StockManagement
//
//  Created by Guillaume Rager on 07/11/2017.
//  Copyright © 2017 CAST. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomerModel : NSObject
{
    NSMutableArray *_customers;
}

@property (nonatomic,strong) NSMutableArray *customers;

+ (instancetype)sharedInstance;

- (void) createCustomersFromDictionary:(NSDictionary*)CustomerAsDictionary;
- (void) cleanUpModel;

@end
