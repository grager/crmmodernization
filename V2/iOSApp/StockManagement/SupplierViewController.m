//
//  SupplierViewController.m
//  StockManagement
//
//  Created by Guillaume Rager on 07/11/2017.
//  Copyright © 2017 CAST. All rights reserved.
//

#import "SupplierViewController.h"
#import "SupplierService.h"

@interface SupplierViewController ()

@end

@implementation SupplierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateNotif:) name:@"SupplierModelUpdated" object:nil];
    
    
    // Do any additional setup after loading the view.
}

- (void) updateNotif:(NSNotification*)aNotif
{
    [suppliersTableView reloadData];
}

- (IBAction) reloadSuppliers
{
    [[SupplierService sharedInstance] getAllSuppliers];
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
