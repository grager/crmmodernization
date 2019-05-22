//
//  SupplierModel.h
//  StockManagement
//
//  Created by Guillaume Rager on 07/11/2017.
//  Copyright © 2017 CAST. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SupplierModel : NSObject
{
    NSMutableArray *_suppliers;
}

@property (nonatomic,strong) NSMutableArray *suppliers;

+ (instancetype)sharedInstance;

- (void) createSuppliersFromDictionary:(NSDictionary*)supplierAsDictionary;
- (void) cleanUpModel;

@end
