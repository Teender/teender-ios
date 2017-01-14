//
//  MainScreen.h
//  Teender
//
//  Created by Paran Sonthalia on 1/14/17.
//  Copyright © 2017 Paran Sonthalia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainScreen : UIViewController <UITableViewDelegate, UITableViewDataSource>
    @property (weak, nonatomic) IBOutlet UILabel *label;
    @property (strong, nonatomic) FIRDatabaseReference *ref;

@end
