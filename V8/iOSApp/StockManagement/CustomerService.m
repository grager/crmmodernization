//
//  CustomerService.m
//  StockManagement
//
//  Created by Guillaume Rager on 07/11/2017.
//  Copyright © 2017 CAST. All rights reserved.
//

#import "CustomerService.h"
#import "CustomerModel.h"
#import "AuthService.h"

static NSString *baseURL = @"https://castapis/";

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
    if([[AuthService sharedInstance] isAuthenticated])
    {
        NSURL *CustomersURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",baseURL,@"customers"]];
        
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
}

- (void) getAllPurchasesForCustomer:(CustomerData*)aCustomerData
{
    NSString *urlAsString = [baseURL stringByAppendingString:@"customers/"];
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

- (void) newCustomer:(CustomerData*)aCustomerData
{
    if([[AuthService sharedInstance] isAuthenticated])
    {
        NSURL *CustomersURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",baseURL,@"customers"]];
        
        //Structuring the URL request
        NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:CustomersURL];
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setHTTPBody:[NSJSONSerialization dataWithJSONObject:[aCustomerData dictionaryRepresentation] options:NSJSONWritingPrettyPrinted error:nil]];

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
}

- (void) updateCustomer:(CustomerData*)aCustomerData
{
    // FIXME: authentication must be activated before updating the customer
//    if([[AuthService sharedInstance] isAuthenticated])
//    {
        NSURL *CustomersURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",baseURL,@"customers/",aCustomerData.customerId]];
        
        //Structuring the URL request
        NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:CustomersURL];
        [urlRequest setHTTPMethod:@"PUT"];
        [urlRequest setHTTPBody:[NSJSONSerialization dataWithJSONObject:[aCustomerData dictionaryRepresentation] options:NSJSONWritingPrettyPrinted error:nil]];

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
                                                                          NSDictionary *answer = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParsingError];
                                                                          
                                                                          if([answer[@"status"] isEqualToString:@"OK"])
                                                                          {
                                                                              [[CustomerModel sharedInstance] updateCustomer:aCustomerData];
                                                                          }
                                                                      }
                                                                      @catch(NSException *exception)
                                                                      {
                                                                          // we might do something...
                                                                      }
                                                                  }
                                                              }
                                                              
                                                          }];
        
        [dataTask resume];
//    }
}

- (void) deleteCustomer:(CustomerData*)aCustomerData
{
    if([[AuthService sharedInstance] isAuthenticated])
    {
        NSURL *CustomersURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",baseURL,@"customers"]];
        
        //Structuring the URL request
        NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:CustomersURL];
        [urlRequest setHTTPMethod:@"DELETE"];
        [urlRequest setHTTPBody:[NSJSONSerialization dataWithJSONObject:@{@"customerId":[aCustomerData customerId]} options:NSJSONWritingPrettyPrinted error:nil]];

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
                                                                          NSDictionary *answer = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParsingError];
                                                                          
                                                                          if([answer[@"status"] isEqualToString:@"OK"])
                                                                          {
                                                                              [[CustomerModel sharedInstance] removeCustomer:aCustomerData];
                                                                          }
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
}

@end
