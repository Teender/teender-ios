//
//  InviteCrush.m
//  Teender
//
//  Created by Paran Sonthalia on 1/15/17.
//  Copyright © 2017 Paran Sonthalia. All rights reserved.
//

#import "InviteCrush.h"
#import <JSQMessagesViewController/JSQMessages.h>

@interface InviteCrush ()

@end

@implementation InviteCrush

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)send:(id)sender {
    NSString *str = [NSString stringWithFormat: @"%@%@%@%@", @"https://teender.herokuapp.com/sendEmail?email=", _email.text, @"&school=Mountain%20View%20High%20School&message=", _message.text];
    
    
    NSString *post = [NSString stringWithFormat:@"postBody=%@",@"Raja"];
//    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[post length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString: str]];
    
    
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//    [request setHTTPBody:postData];
    
    NSURLConnection *theConnection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    

}
@end
