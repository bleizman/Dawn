//
//  LoginViewController.m
//  Dawn
//
//  Created by Ben Leizman on 4/16/15.
//  Copyright (c) 2015 Dawnteam. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <FBSDKCoreKit/FBSDKProfile.h>
#import <ParseUI/ParseUI.h>
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    //Test Interaction with Parse database
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] = @"THIS WORKS!";
    //[testObject saveInBackground];
    
    
    // Initialize fb button
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    [self.view addSubview:loginButton];
    
    
    // Test out a User
    currentUser = [[DawnUser alloc] init];
    
    DawnAlarm *alarm1 = [[DawnAlarm alloc] init];
    alarm1.name = @"Test Alarm";
    
    DawnAlarm *alarm2 = [[DawnAlarm alloc] init];
    alarm2.name = @"Test Alarm 2: This is Working!";
    
    DawnAlarm *alarm3 = [[DawnAlarm alloc] init];
    alarm3.name = @"The User works!";
    
    [currentUser addAlarm:alarm1];
    [currentUser addAlarm:alarm2];
    [currentUser addAlarm:alarm3];
    
    
    if ([FBSDKAccessToken currentAccessToken]) {
        //code here
        //code here to skip to next page
        NSLog(@"User's Name is %@", [FBSDKProfile currentProfile].name);
        currentUser.name = [FBSDKProfile currentProfile].name;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
- (void)_loginWithFacebook {
    // Set permissions required from the facebook user account
    NSArray *permissions = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];
    
    // Login PFUser using Facebook
    [PFFacebookUtils logInInBackgroundWithReadPermissions:permissions block:^(PFUser *user, NSError *error) {
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Facebook login.");
        } else if (user.isNew) {
            NSLog(@"User signed up and logged in through Facebook!");
        } else {
            NSLog(@"User logged in through Facebook!");
        }
    }];
}
 */


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
