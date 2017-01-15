//
//  AddCrush.h
//  Teender
//
//  Created by Paran Sonthalia on 1/14/17.
//  Copyright © 2017 Paran Sonthalia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddCrush : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textField;
- (IBAction)search:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
