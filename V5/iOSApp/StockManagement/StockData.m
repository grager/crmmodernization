//
//  StockData.m
//  StockManagement
//
//  Created by Guillaume Rager on 07/11/2017.
//  Copyright © 2017 CAST. All rights reserved.
//

#import "StockData.h"

@implementation StockData

+ (StockData*) newWithDictionary:(NSDictionary *)aDictionary
{
    StockData *newOne = [[StockData alloc] init];
    
    newOne.name = aDictionary[@"name"];
    newOne.number = aDictionary[@"number"];

    return newOne;
}


@end
