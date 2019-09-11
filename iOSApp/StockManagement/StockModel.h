//
//  StockModel.h
//  StockManagement
//
//  Created by Guillaume Rager on 07/11/2017.
//  Copyright © 2017 CAST. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StockModel : NSObject
{
    NSMutableArray *_stocks;
}

@property (nonatomic,strong) NSMutableArray *stocks;

+ (instancetype)sharedInstance;

- (void) createStocksFromDictionary:(NSDictionary*)stockAsDictionary;
- (void) cleanUpModel;

@end
