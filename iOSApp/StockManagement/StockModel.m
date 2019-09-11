//
//  StockModel.m
//  StockManagement
//
//  Created by Guillaume Rager on 07/11/2017.
//  Copyright © 2017 CAST. All rights reserved.
//

#import "StockModel.h"
#import "StockData.h"

@implementation StockModel

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    
    return sharedInstance;
}

- (void) createStocksFromDictionary:(NSDictionary*)stockAsDictionary
{
    if(![stockAsDictionary[@"status"] isEqualToString:@"error"])
    {
        if(!self.stocks)
            self.stocks = [NSMutableArray array];
        
        NSArray *listofstocks = stockAsDictionary[@"stocks"];
        
        for(NSDictionary *aDictionary in listofstocks)
        {
            [self.stocks addObject:[StockData newWithDictionary:aDictionary]];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"StockModelUpdated" object:self];
    }
}

- (void) cleanUpModel
{
    [self.stocks removeAllObjects];
}

@end
