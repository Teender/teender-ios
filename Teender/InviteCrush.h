//
//  InviteCrush.h
//  Teender
//
//  Created by Paran Sonthalia on 1/15/17.
//  Copyright © 2017 Paran Sonthalia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InviteCrush : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextView *message;
- (IBAction)send:(id)sender;

@end
