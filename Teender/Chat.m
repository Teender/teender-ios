//
//  Chat.m
//  Teender
//
//  Created by Paran Sonthalia on 1/14/17.
//  Copyright © 2017 Paran Sonthalia. All rights reserved.
//

#import "Chat.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "AppDelegate.h"
@import Firebase;

@interface Chat ()

@end

@implementation Chat {
    NSArray *tableData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    startIndex = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    tableData = [NSArray arrayWithObjects:@"", nil];
    
    
    [self.textField becomeFirstResponder];
    
    self.rootRef = [[FIRDatabase database] reference];
    
    
    if ([FBSDKAccessToken currentAccessToken]) {
        credential = [FIRFacebookAuthProvider
                      credentialWithAccessToken:[FBSDKAccessToken currentAccessToken]
                      .tokenString];
        
        FIRUser *currentUser = [FIRAuth auth].currentUser;
        firebaseid = currentUser.uid;
        
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{

    
    [[FIRAuth auth] signInWithCredential:credential
                              completion:^(FIRUser *user, NSError *error) {
                                  if (error) {
                                      // an error occurred while attempting login
                                  } else {
                                      [_rootRef
                                       observeEventType:FIRDataEventTypeValue
                                       withBlock:^(FIRDataSnapshot *snapshot) {
                                           
                                           AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                                           NSLog(@"%@", appDelegate.chatName);
                                           
                                           
                                           NSDictionary *messages = snapshot.value[@"messages"];
                                           
                                           [[_rootRef queryOrderedByChild:@"messages"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *snapshot) {
                                               
                                               for ( FIRDataSnapshot *child in snapshot.children) {
                                                   
                                                   NSLog(@"child.key = %@",child.key);
                                                   
                                               }
                                           }];
                                           
                                           
                                           NSMutableArray *content = [messages objectForKey: appDelegate.chatName];
                                           
                                           chatHistory = [[NSMutableArray alloc] init];
                                           users = [[NSMutableArray alloc] init];

                                           messagesCount = [content count];
                                           
                                           for(int x = 0; x < [content count]; x++) {
                                               
                                               NSString *strFromInt = [NSString stringWithFormat:@"%d",x];

                                               NSDictionary *asdf = [content objectAtIndex: x];
                                               
                                               [chatHistory addObject: [asdf valueForKey: @"text"]];
                                               
                                               
//                                               NSLog(chatHistory[x]);
                                           }
                                           for(int x = 0; x < [content count]; x++) {
                                               
                                               NSString *strFromInt = [NSString stringWithFormat:@"%d",x];
                                               
                                               NSDictionary *asdf = [content objectAtIndex: x];
                                               
                                               [users addObject: [asdf valueForKey: @"user"]];
                                               startIndex = 0;
                                               
                                               //                                               NSLog(chatHistory[x]);
                                           }
                                           
                                           
                                           tableData = [chatHistory copy];
                                           [_tableView reloadData];
                                           
//                                           NSMutableArray *chats = [messages objectForKey: @""];
                                           
                                           
                                           
                                       } withCancelBlock:^(NSError * _Nonnull error) {
                                           NSLog(@"%@", error.localizedDescription);
                                       }];
                                      
                                  }
                              }];
        });
    NSIndexPath* ipath = [NSIndexPath indexPathForRow: [self.tableView numberOfRowsInSection:0]-1 inSection: 0];
    [self.tableView scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionTop animated: YES];


    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    if(startIndex < [users count]) {
        if([[users objectAtIndex:startIndex] isEqualToString: firebaseid]) {
            cell.textLabel.textAlignment = NSTextAlignmentRight;
            cell.textLabel.textColor = [UIColor blueColor];
        }
    }
    startIndex++;
    return cell;
}


- (IBAction)send:(id)sender {
    if(![self.textField.text  isEqual: @""]) {
        message = self.textField.text;
        send = true;
        self.textField.text = @"";
    }
    
    

    
    [[FIRAuth auth] signInWithCredential:credential
                              completion:^(FIRUser *user, NSError *error) {
                                  if (error) {
                                      // an error occurred while attempting login
                                  } else {
                                      [_rootRef
                                       observeEventType:FIRDataEventTypeValue
                                       withBlock:^(FIRDataSnapshot *snapshot) {
                                           AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];

                                           
                                           NSDictionary *messages = snapshot.value[@"messages"];
                                           NSMutableArray *content = [messages objectForKey: appDelegate.chatName];
                                           
                                           chatHistory = [[NSMutableArray alloc] init];
                                           messagesCount = [content count];
                                           
                                           if(send == true) {
                                               NSString *key = [[_rootRef child:@"messages"] childByAutoId].key;
                                               
                                                [[[[[_rootRef child:@"messages"] child: appDelegate.chatName] child:key ] child: @"text"] setValue: message];
                                                   
                                                [[[[[_rootRef child:@"messages"] child: appDelegate.chatName] child:[NSString stringWithFormat:@"%d",messagesCount] ] child: @"user"] setValue: firebaseid];
                                               send = false;
                                               
                                           }
                                           
                                           for(int x = 0; x < [content count]; x++) {
                                               
                                               NSString *strFromInt = [NSString stringWithFormat:@"%d",x];
                                               
                                               NSDictionary *asdf = [content objectAtIndex: x];
                                               
                                               [chatHistory addObject: [asdf valueForKey: @"text"]];
                                               
                                               //                                               NSLog(chatHistory[x]);
                                           }
                                           tableData = [chatHistory copy];
                                           [_tableView reloadData];
                                           
                                           //                                           NSMutableArray *chats = [messages objectForKey: @""];
                                           
                                           
                                           
                                           NSTimer* myTimer = [NSTimer scheduledTimerWithTimeInterval: 0.1  target: self
                                                                                             selector: @selector(scrollDown) userInfo: nil repeats: NO];
                                           

                                       } withCancelBlock:^(NSError * _Nonnull error) {
                                           NSLog(@"%@", error.localizedDescription);
                                       }];
                                      
                                  }
                              }];
}

- (IBAction)back:(id)sender {
    [self.view endEditing:YES];

    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void) scrollDown {
        NSIndexPath* ipath = [NSIndexPath indexPathForRow: [self.tableView numberOfRowsInSection:0]-1 inSection: 0];
        [self.tableView scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionTop animated: YES];
    
}
@end
