//
//  SignupViewController.m
//  StockManagement
//
//  Created by Guillaume Rager on 07/11/2017.
//  Copyright © 2017 CAST. All rights reserved.
//

#import "SignupViewController.h"

@interface SignupViewController ()

@end

@implementation SignupViewController

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    
    return sharedInstance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)signupActivated:(id)sender
{
    NSString *userAsString = [userTextField text];
    NSString *userEmailAsString = [userEmailTextField text];

    if([userAsString isEqualToString:@""])
    {
        UIAlertController *errorController = [UIAlertController alertControllerWithTitle:@"User is empty" message:@"Please, enter a username!" preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:errorController animated:YES completion:^{
            
        }];
    }
    else if([userEmailAsString isEqualToString:@""])
    {
        UIAlertController *errorController = [UIAlertController alertControllerWithTitle:@"Email is empty" message:@"Please, enter an email!" preferredStyle:UIAlertControllerStyleAlert];
            
        [self presentViewController:errorController animated:YES completion:^{
                
        }];
    }
    else
    {
        NSString *pwdAsString = [pwdTextField text];
        NSString *confirmPwdAsString = [confirmpwdTextField text];
        
        if(![confirmPwdAsString isEqualToString:@""] &&
           ![pwdAsString isEqualToString:@""] &&
           [[pwdTextField text] isEqualToString:[confirmpwdTextField text]])
        {
            // calling the authentication service signup
            
            NSString *baseURL = @"https://castapis";
            NSURL *signupURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",baseURL,@"/auth/signup"]];
            
            //Structuring the URL request
            NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:signupURL];
            [urlRequest setHTTPMethod:@"POST"];
            [urlRequest setHTTPBody:[NSJSONSerialization dataWithJSONObject:@{@"email":userEmailAsString,@"user":userAsString,@"password":pwdAsString} options:NSJSONWritingPrettyPrinted error:nil]];
            
            // Start NSURLSession
            NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
            NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
            
            
            NSURLSessionDataTask *signupTask =[defaultSession dataTaskWithRequest:urlRequest
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
                                                                          
                                                                          [[NSNotificationCenter defaultCenter] postNotificationName:@"SignupCompleted" object:@{@"jwtToken":[httpResponse allHeaderFields][@"jwtToken"]}];
                                                                      }
                                                                      else if(statusCode == 400)
                                                                      {
                                                                          [self _somethingWentWrong];
                                                                      }
                                                                      else if(statusCode == 422)
                                                                      {
                                                                          [self _somethingWentWrong];
                                                                      }
                                                                  }
                                                                  
                                                              }];
            
            [signupTask resume];
            
        }
        else
        {
            UIAlertController *errorController = [UIAlertController alertControllerWithTitle:@"Password are not matching" message:@"Please, check the passwords!" preferredStyle:UIAlertControllerStyleAlert];
            
            [self presentViewController:errorController animated:YES completion:^{
                
            }];
            
        }
    }
}

- (void) _somethingWentWrong
{
    // to be completed
}

@end
