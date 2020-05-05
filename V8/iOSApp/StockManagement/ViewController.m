//
//  ViewController.m
//  StockManagement
//
//  Created by Guillaume Rager on 07/11/2017.
//  Copyright © 2017 CAST. All rights reserved.
//

#import "ViewController.h"
#import "AuthService.h"
#import "AWSCognitoAuth.h"

@interface ViewController ()

@end

@interface ViewController () <AWSCognitoAuthDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *signInButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *signOutButton;
@property (nonatomic) BOOL firstLoad;
@end

@implementation ViewController

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
    
    [AuthService sharedInstance].auth = [AWSCognitoAuth defaultCognitoAuth];
    if([[AuthService sharedInstance].auth.authConfiguration.appClientId containsString:@"SETME"]){
        [self alertWithTitle:@"Error" message:@"Info.plist missing necessary config under AWS->CognitoUserPool->Default"];
    }
    [AuthService sharedInstance].auth.delegate = self;
    self.firstLoad = YES;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if(self.firstLoad){
        [self signInTapped:nil];
    }
    self.firstLoad = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark AWSCognitoAuthInteractiveAuthenticationDelegate
- (UIViewController *) getViewController {
    return self;
}

- (IBAction)signInTapped:(UIBarButtonItem *)sender {
    [[AuthService sharedInstance].auth getSession:self completion:^(AWSCognitoAuthUserSession * _Nullable session, NSError * _Nullable error) {
        if(error){
            [self alertWithTitle:@"Error" message:error.userInfo[@"error"]];
            [AuthService sharedInstance].session = nil;
        }else {
            [AuthService sharedInstance].session = session;
        }
        [self refresh];
    }];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([AuthService sharedInstance].session){
        return [self getBestToken].claims.count;
    }
    return 0;
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSString *key = [self getBestToken].claims.allKeys[indexPath.row];
    cell.textLabel.text = key;
    cell.detailTextLabel.text = [[[self getBestToken].claims objectForKey:key] description];
    return cell;
}*/

-(void) refresh {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.signInButton.enabled = ![AuthService sharedInstance].session;
        self.signOutButton.enabled = [AuthService sharedInstance].session != nil;
        //[self.tableView reloadData];
        self.title = [AuthService sharedInstance].session.username;
    });
}

- (IBAction)signOutTapped:(id)sender {
    [[AuthService sharedInstance].auth signOut:^(NSError * _Nullable error) {
        if(!error){
            [AuthService sharedInstance].session= nil;
            [self alertWithTitle:@"Info" message:@"Session completed"];
            [self refresh];
        }else {
            [self alertWithTitle:@"Error" message:error.userInfo[@"error"]];
        }
    }];
}

- (nullable AWSCognitoAuthUserSessionToken *) getBestToken {
    
    return [AuthService sharedInstance].session.idToken;
}

- (void) alertWithTitle: (NSString *) title message:(NSString *)message {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:title
                                     message:message
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction
                                 actionWithTitle:@"Ok"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action) {
                                     [alert dismissViewControllerAnimated:NO completion:nil];
                                 }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    });
}

@end
