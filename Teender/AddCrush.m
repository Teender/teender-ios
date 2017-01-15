//
//  AddCrush.m
//  Teender
//
//  Created by Paran Sonthalia on 1/14/17.
//  Copyright © 2017 Paran Sonthalia. All rights reserved.
//

#import "AddCrush.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface AddCrush ()

@end

@implementation AddCrush {
    NSArray *tableData;
}


@synthesize textField;

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    GET graph.facebook.com
//    /search?
//    q={name}&
//    type={user}
    
    tableData = [NSArray arrayWithObjects:@"", nil];

    
    self.tableView.dataSource = self;
    
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


- (IBAction)search:(id)sender {
    [self.view endEditing:YES];
    
    NSString *str = [NSString stringWithFormat: @"%@%@%@%@", @"https://graph.facebook.com/search?q=", textField.text, @"&type=user&access_token=", [FBSDKAccessToken currentAccessToken].tokenString];
    
    
    NSMutableURLRequest *request =
    [NSMutableURLRequest requestWithURL:[NSURL
                                         URLWithString:str]
                            cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                        timeoutInterval:10
     ];
    
    [request setHTTPMethod: @"GET"];
    
    NSError *requestError = nil;
    NSURLResponse *urlResponse = nil;
    
    
    NSData *response1 =
    [NSURLConnection sendSynchronousRequest:request
                          returningResponse:&urlResponse error:&requestError];
    
    NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:response1
                                                             options:0
                                                               error:NULL];
    
    NSMutableArray *greetingId = [greeting objectForKey:@"data"];
    NSMutableArray *tableData2 = [tableData mutableCopy];
    for(int x = 0; x < 25; x++) {
        NSDictionary *gre = [greetingId objectAtIndex: x];
        NSString *name = [gre objectForKey:@"name"];
        [tableData2 replaceObjectAtIndex:x withObject: name];
    }
    tableData = [tableData2 copy];
    
    
    
    
//    NSString *greetingContent = [greeting objectForKey:@"content"];
    
//    NSLog(@"%@", response1);
    
}
@end
