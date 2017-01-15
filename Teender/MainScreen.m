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
#import "Chat.h"
#import "AppDelegate.h"

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
    
    
    tableData = [NSArray arrayWithObjects:@"", nil];

    
    
//    for(int x = 0; x < ; x++) {
//        
//    }
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
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
                                     NSLog(@"%@", snapshot.value[@"users2"]);
                                      NSDictionary *users = snapshot.value[@"users2"];
                                      NSDictionary *objezc = [users objectForKey: firebaseid];
                                      NSMutableArray *cha = [objezc objectForKey:@"chat"];
                                      chats = [[NSMutableArray alloc] init];
                                      
                                      for(int x = 0; x < [cha count]; x++) {
//                                        NSLog([cha objectAtIndex:x]);
                                          [chats addObject:[cha objectAtIndex:x]];
                                          NSLog(@"%@", [chats objectAtIndex:x]);
                                      }
                                      tableData = [chats copy];
                                      [_tableView reloadData];
                                      NSLog(@"");
                                      
                                     
                                     // ...
                                 } withCancelBlock:^(NSError * _Nonnull error) {
                                     NSLog(@"%@", error.localizedDescription);
                                 }];
                                 
                                 [[[[_rootRef child:@"users2"] child:firebaseid] child:@"fbid" ] setValue: facebookid];
                             }
                         }];
    
    NSLog(@"%@", [FBSDKAccessToken currentAccessToken].tokenString);
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //    NSLog(cell.textLabel.text);
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    appDelegate.chatName = cell.textLabel.text;
    
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"chat"];
    [self presentViewController:vc animated:YES completion:NULL];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"teencell";
    
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
