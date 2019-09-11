//
//  StockData.h
//  StockManagement
//
//  Created by Guillaume Rager on 07/11/2017.
//  Copyright © 2017 CAST. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StockData : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *number;

+ (StockData*) newWithDictionary:(NSDictionary*)aDictionary;

@end
