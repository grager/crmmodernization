//
//  AuthViewController.m
//  StockManagement
//
//  Created by Guillaume Rager on 07/11/2017.
//  Copyright © 2017 CAST. All rights reserved.
//

#import "AuthViewController.h"
#import "SignupViewController.h"

@interface AuthViewController ()

@end

@implementation AuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginActivated:(id)sender
{
    NSString *pwdAsString = [pwdTextField text];
    NSString *userAsString = [userTextField text];
    
    if(![userAsString isEqualToString:@""] &&
       ![pwdAsString isEqualToString:@""])
    {
        // calling the authentication service signup
        
        NSString *baseURL = @"http://authentication";
        NSURL *signupURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",baseURL,@"/users/signin"]];
        
        //Structuring the URL request
        NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:signupURL];
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setHTTPBody:[NSJSONSerialization dataWithJSONObject:@{@"user":userAsString,@"password":pwdAsString} options:NSJSONWritingPrettyPrinted error:nil]];
        
        // Start NSURLSession
        NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        
        NSURLSessionDataTask *signinTask =[defaultSession dataTaskWithRequest:urlRequest
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
                                                                        
                                                                        [[NSNotificationCenter defaultCenter] postNotificationName:@"SigninCompleted" object:@{@"jwtToken":[httpResponse allHeaderFields][@"jwtToken"]}];
                                                                        
                                                                        [self presentViewController:[ViewController sharedInstance] animated:YES completion:^{
                                                                            
                                                                        }];
                                                                    }
                                                                    else if (statusCode == 400)
                                                                    {
                                                                        NSLog (@"statuscode 400");
                                                                        
                                                                        [self _displaySomethingWentWrong];
                                                                        

                                                                    }
                                                                }
                                                                
                                                            }];
        
        [signinTask resume];
    }
}

- (IBAction)gotoSignupActivated:(id)sender
{
    [self presentViewController:[SignupViewController sharedInstance] animated:YES completion:^{
            
    }];
}
    
    - (void) _displaySomethingWentWrong
    {
        // to be completed
    }

@end
