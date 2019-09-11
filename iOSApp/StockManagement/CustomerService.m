//
//  CustomerService.m
//  StockManagement
//
//  Created by Guillaume Rager on 07/11/2017.
//  Copyright © 2017 CAST. All rights reserved.
//

#import "CustomerService.h"
#import "CustomerModel.h"

@implementation CustomerService

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    
    return sharedInstance;
}

- (void) getAllCustomers
{
    NSString *baseURL = @"http://mystockmanagement.com/";
    NSURL *CustomersURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",baseURL,@"api/customers"]];
    
    //Structuring the URL request
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:CustomersURL];
    [urlRequest setHTTPMethod:@"GET"];
    
    // Start NSURLSession
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *dataTask =[defaultSession dataTaskWithRequest:urlRequest
                                                      completionHandler:^(NSData *data,
                                                                          NSURLResponse *response,
                                                                          NSError *error){
                                                          
          // Handle response
          NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
          NSInteger statusCode = [httpResponse statusCode];
          if(error == nil)
          {
              if (statusCode == 200)
              {
                  NSLog (@"statuscode 200");
                  
                  @try
                  {
                      NSError *jsonParsingError;
                      NSDictionary *CustomerAsDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParsingError];

                      [[CustomerModel sharedInstance] createCustomersFromDictionary:CustomerAsDictionary];
                  }
                  @catch(NSException *exception)
                  {
                      // we might do something...
                  }
              }
          }
                                                  
  }];
    
    [dataTask resume];
}

- (void) getAllPurchasesForCustomer:(CustomerData*)aCustomerData
{
    NSString *baseURL = @"http://mystockmanagement.com/";
    
    NSString *urlAsString = [baseURL stringByAppendingString:@"api/customers/"];
    urlAsString = [urlAsString stringByAppendingString:aCustomerData.customerId];
    urlAsString = [urlAsString stringByAppendingString:@"/purchases"];

    NSURL *CustomersURL = [NSURL URLWithString:urlAsString];
    
    //Structuring the URL request
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:CustomersURL];
    [urlRequest setHTTPMethod:@"GET"];
    
    // Start NSURLSession
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *dataTask =[defaultSession dataTaskWithRequest:urlRequest
                                                      completionHandler:^(NSData *data,
                                                                          NSURLResponse *response,
                                                                          NSError *error){
                                                          
                                                          // Handle response
                                                          NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                                                          NSInteger statusCode = [httpResponse statusCode];
                                                          if(error == nil)
                                                          {
                                                              if (statusCode == 200)
                                                              {
                                                                  NSLog (@"statuscode 200");
                                                                  
                                                                  @try
                                                                  {
                                                                      NSError *jsonParsingError;
                                                                      NSDictionary *CustomerAsDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParsingError];
                                                                      
                                                                      [[CustomerModel sharedInstance] createCustomersFromDictionary:CustomerAsDictionary];
                                                                  }
                                                                  @catch(NSException *exception)
                                                                  {
                                                                      // we might do something...
                                                                  }
                                                              }
                                                          }
                                                          
                                                      }];
    
    [dataTask resume];
}

@end
