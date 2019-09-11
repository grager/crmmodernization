//
//  CustomerData.h
//  StockManagement
//
//  Created by Guillaume Rager on 07/11/2017.
//  Copyright © 2017 CAST. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomerData : NSObject

@property (strong, nonatomic) NSString *customerId;

+ (CustomerData*) newWithDictionary:(NSDictionary*)aDictionary;

@end
