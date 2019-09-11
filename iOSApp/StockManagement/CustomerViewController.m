//
//  CustomerViewController.m
//  StockManagement
//
//  Created by Guillaume Rager on 07/11/2017.
//  Copyright © 2017 CAST. All rights reserved.
//

#import "CustomerViewController.h"
#import "CustomerService.h"

@interface CustomerViewController ()

@end

@implementation CustomerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateNotif:) name:@"CustomerModelUpdated" object:nil];
    
    
    // Do any additional setup after loading the view.
}

- (void) updateNotif:(NSNotification*)aNotif
{
    [customersTableView reloadData];
}

- (IBAction) reloadCustomers
{
    [[CustomerService sharedInstance] getAllCustomers];
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

@end
