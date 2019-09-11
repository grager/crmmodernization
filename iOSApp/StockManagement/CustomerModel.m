//
//  CustomerModel.m
//  StockManagement
//
//  Created by Guillaume Rager on 07/11/2017.
//  Copyright © 2017 CAST. All rights reserved.
//

#import "CustomerModel.h"
#import "CustomerData.h"

@implementation CustomerModel

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    
    return sharedInstance;
}

- (void) createCustomersFromDictionary:(NSDictionary*)CustomerAsDictionary
{
    if(![CustomerAsDictionary[@"status"] isEqualToString:@"error"])
    {
        if(!self.customers)
            self.customers = [NSMutableArray array];
        
        NSArray *listofCustomers = CustomerAsDictionary[@"customers"];
        
        for(NSDictionary *aDictionary in listofCustomers)
        {
            [self.customers addObject:[CustomerData newWithDictionary:aDictionary]];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CustomerModelUpdated" object:self];
    }
}

- (void) cleanUpModel
{
    [self.customers removeAllObjects];
}

@end
