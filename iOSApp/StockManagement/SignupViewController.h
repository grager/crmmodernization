//
//  SignupViewController.h
//  StockManagement
//
//  Created by Guillaume Rager on 07/11/2017.
//  Copyright © 2017 CAST. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ViewController.h"

@interface SignupViewController : UIViewController
{
    IBOutlet UITextField *userTextField;
    IBOutlet UITextField *userEmailTextField;
    IBOutlet UITextField *pwdTextField;
    IBOutlet UITextField *confirmpwdTextField;
    IBOutlet UIButton *signupButton;
}

- (IBAction)signupActivated:(id)sender;

+ (id) sharedInstance;

@end
