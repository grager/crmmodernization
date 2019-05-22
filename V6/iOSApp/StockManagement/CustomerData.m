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
    newOne.fullname = aDictionary[@"fullname"];
    newOne.address = aDictionary[@"address"];
    newOne.company = aDictionary[@"company"];
    newOne.country = aDictionary[@"country"];


    return newOne;
}

- (NSDictionary*) dictionaryRepresentation;
{
    return @{@"fullname":self.fullname, @"customerId":self.customerId, @"address":self.address, @"country":self.country, @"company":self.company};
}


@end
