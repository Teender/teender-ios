//
//  Chat.h
//  Teender
//
//  Created by Paran Sonthalia on 1/14/17.
//  Copyright © 2017 Paran Sonthalia. All rights reserved.
//

#import <UIKit/UIKit.h>

@import Firebase;

@interface Chat : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    FIRAuthCredential *credential;
    NSMutableArray *chatHistory;
    NSMutableArray *users;
    NSString *firebaseid;
    int startIndex;


    int messagesCount;
    Boolean send;
    NSString *message;


}

-(IBAction) textFieldDoneEditing : (id) sender;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) FIRDatabaseReference *rootRef;

@property (weak, nonatomic) IBOutlet UIButton *send;
- (IBAction)send:(id)sender;
- (IBAction)back:(id)sender;

@end
