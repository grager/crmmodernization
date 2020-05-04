//
//  StockService.h
//  StockManagement
//
//  Created by Guillaume Rager on 07/11/2017.
//  Copyright © 2017 CAST. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StockData;

@interface StockService : NSObject

+ (instancetype)sharedInstance;
- (void) getAllStocks;
- (void) getStockWithId:(NSString*)anId;
- (void) newStock:(StockData*)aStockData;
- (void) deleteStock:(StockData*)aStockData;

@end
