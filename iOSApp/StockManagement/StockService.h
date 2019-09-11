//
//  StockService.h
//  StockManagement
//
//  Created by Guillaume Rager on 07/11/2017.
//  Copyright © 2017 CAST. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StockService : NSObject

+ (instancetype)sharedInstance;
- (void) getAllStocks;

@end
