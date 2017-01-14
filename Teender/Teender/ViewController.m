//
//  ViewController.m
//  Teender
//
//  Created by Paran Sonthalia on 1/14/17.
//  Copyright © 2017 Paran Sonthalia. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "MainScreen.h"
#import "AppDelegate.h"
@import Firebase


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.center = self.view.center;
    [self.view addSubview:loginButton];

//    NSLog(@"Access Token");
//    NSString *accessToken = [FBSDKAccessToken currentAccessToken];
//    NSLog(accessToken);
    
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.delegate = self;
    
    FIRAuthCredential *credential = [FIRFacebookAuthProvider
                                     credentialWithAccessToken:[FBSDKAccessToken currentAccessToken]
                                     .tokenString];
    
    NSError *signOutError;
    BOOL status = [[FIRAuth auth] signOut:&signOutError];
    if (!status) {
        NSLog(@"Error signing out: %@", signOutError);
        return;
    }
   
    
/*sign out
                           
      NSError *signOutError;
      BOOL status = [[FIRAuth auth] signOut:&signOutError];
      if (!status) {
          NSLog(@"Error signing out: %@", signOutError);
          return;
      }
 */
     
    
}

- (void) viewDidAppear:(BOOL)animated {
//    [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];

    if ([FBSDKAccessToken currentAccessToken]) {
        // User is logged in, do work such as go to next view controller.
        NSLog(@"logged in");
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Mains"];
        [self presentViewController:vc animated:YES completion:NULL];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
