//
//  CustomerService.h
//  StockManagement
//
//  Created by Guillaume Rager on 07/11/2017.
//  Copyright © 2017 CAST. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomerData.h"

@interface CustomerService : NSObject

+ (instancetype)sharedInstance;
- (void) getAllCustomers;
- (void) getAllPurchasesForCustomer:(CustomerData*)aCustomerData;
- (void) newCustomer:(CustomerData*)aCustomerData;
- (void) updateCustomer:(CustomerData*)aCustomerData;
- (void) deleteCustomer:(CustomerData*)aCustomerData;

@end
