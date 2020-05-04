//
//  SupplierModel.m
//  StockManagement
//
//  Created by Guillaume Rager on 07/11/2017.
//  Copyright © 2017 CAST. All rights reserved.
//

#import "SupplierModel.h"
#import "SupplierData.h"

@implementation SupplierModel

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    
    return sharedInstance;
}

- (void) createSuppliersFromDictionary:(NSDictionary*)supplierAsDictionary
{
    if(![supplierAsDictionary[@"status"] isEqualToString:@"error"])
    {
        if(!self.suppliers)
            self.suppliers = [NSMutableArray array];
        
        NSArray *listofsuppliers = supplierAsDictionary[@"suppliers"];
        
        for(NSDictionary *aDictionary in listofsuppliers)
        {
            [self.suppliers addObject:[SupplierData newWithDictionary:aDictionary]];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SupplierModelUpdated" object:self];
    }
}

- (void) cleanUpModel
{
    [self.suppliers removeAllObjects];
}

@end
