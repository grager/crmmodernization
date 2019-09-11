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
@property (strong, nonatomic) NSString *fullname;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSString *company;

+ (CustomerData*) newWithDictionary:(NSDictionary*)aDictionary;
- (NSDictionary*) dictionaryRepresentation;

@end
