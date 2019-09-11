//
//  CustomerData.m
//  StockManagement
//
//  Created by Guillaume Rager on 07/11/2017.
//  Copyright © 2017 CAST. All rights reserved.
//

#import "CustomerData.h"

@implementation CustomerData

+ (CustomerData*) newWithDictionary:(NSDictionary *)aDictionary
{
    CustomerData *newOne = [[CustomerData alloc] init];
    
    newOne.customerId = aDictionary[@"customerId"];
    
    return newOne;
}


@end
