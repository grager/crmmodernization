//
//  AuthViewController.h
//  StockManagement
//
//  Created by Guillaume Rager on 07/11/2017.
//  Copyright © 2017 CAST. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ViewController.h"

@interface AuthViewController : UIViewController
{
    IBOutlet UITextField *userTextField;
    IBOutlet UITextField *pwdTextField;
    IBOutlet UIButton *loginButton;
}

- (IBAction)loginActivated:(id)sender;

@end
