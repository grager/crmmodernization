//
//  SupplierData.m
//  StockManagement
//
//  Created by Guillaume Rager on 07/11/2017.
//  Copyright © 2017 CAST. All rights reserved.
//

#import "SupplierData.h"

@implementation SupplierData

+ (SupplierData*) newWithDictionary:(NSDictionary *)aDictionary
{
    SupplierData *newOne = [[SupplierData alloc] init];
    
    newOne.supplierId = aDictionary[@"suppliedId"];
    
    return newOne;
}


@end
