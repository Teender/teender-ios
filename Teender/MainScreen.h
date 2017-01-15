//
//  MainScreen.h
//  Teender
//
//  Created by Paran Sonthalia on 1/14/17.
//  Copyright © 2017 Paran Sonthalia. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;

@interface MainScreen : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    FIRAuthCredential *credential;
}
    @property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) FIRDatabaseReference *rootRef;

@end
