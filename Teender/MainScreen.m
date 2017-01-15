//
//  MainScreen.m
//  Teender
//
//  Created by Paran Sonthalia on 1/14/17.
//  Copyright © 2017 Paran Sonthalia. All rights reserved.
//

#import "MainScreen.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@import Firebase;

@interface MainScreen ()

@end

@implementation MainScreen {
    NSArray *tableData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    if ([FBSDKAccessToken currentAccessToken]) {
        // User is logged in, do work such as go to next view controller.
        NSLog(@"logged in");
        facebookid = [FBSDKAccessToken currentAccessToken].userID;
        NSLog([FBSDKAccessToken currentAccessToken].tokenString);
        
        credential = [FIRFacebookAuthProvider
                                         credentialWithAccessToken:[FBSDKAccessToken currentAccessToken]
                                         .tokenString];
        
        FIRUser *currentUser = [FIRAuth auth].currentUser;
        firebaseid = currentUser.uid;
        
    }
    
    
    tableData = [NSArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];
    
    self.tableView.dataSource = self;
    
    
//    FIRDatabaseReference *rootRef= [[FIRDatabase database] reference];
    self.rootRef = [[FIRDatabase database] reference];

    
    [[FIRAuth auth] signInWithCredential:credential
                              completion:^(FIRUser *user, NSError *error) {
                             if (error) {
                                 // an error occurred while attempting login
                             } else {
                                 // user is logged in, check authData for data
//                                 [_rootRef
//                                  observeEventType:FIRDataEventTypeChildAdded
//                                  withBlock:^(FIRDataSnapshot *snapshot) {
//                                      
//                                      NSLog(@"hi %@", snapshot.value[@"test"]);
//                                  }];
                                 
                                 [_rootRef
                                  observeEventType:FIRDataEventTypeValue
                                  withBlock:^(FIRDataSnapshot *snapshot) {
                                     // Get user value
                                     //User *user = [[User alloc] initWithUsername:snapshot.value[@"username"]];
                                     NSLog(@"%@", snapshot.value[@"test"]);
                                     
                                     // ...
                                 } withCancelBlock:^(NSError * _Nonnull error) {
                                     NSLog(@"%@", error.localizedDescription);
                                 }];
                                 
                                 [[[[_rootRef child:@"users2"] child:firebaseid] child:@"fbid" ] setValue: facebookid];
                             }
                         }];
    
    NSLog(@"%@", [FBSDKAccessToken currentAccessToken].tokenString);
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    return cell;
}
    

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
