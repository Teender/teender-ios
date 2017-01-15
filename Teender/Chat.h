//
//  Chat.h
//  Teender
//
//  Created by Paran Sonthalia on 1/14/17.
//  Copyright © 2017 Paran Sonthalia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Chat : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    
}

-(IBAction) textFieldDoneEditing : (id) sender;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
