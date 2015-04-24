//
//  LoginViewController.m
//  Dawn
//
//  Created by Ben Leizman on 4/16/15.
//  Copyright (c) 2015 Dawnteam. All rights reserved.
//

#import "LoginViewController.h"
#import "MyAlarmsTableViewController.h"
#import <Parse/Parse.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <FBSDKCoreKit/FBSDKProfile.h>
#import <ParseUI/ParseUI.h>
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UILabel *WelcomeLabel;
@property (weak, nonatomic) IBOutlet UIButton *EnterDawn;

@end

@implementation LoginViewController

- (void)loadView {
    [super loadView];
    if ([FBSDKAccessToken currentAccessToken]) {
        
        NSString *welcome = @"Welcome back to Dawn, ";
        welcome = [welcome stringByAppendingString:[FBSDKProfile currentProfile].firstName];
        self.WelcomeLabel.text = welcome;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize fb button - UI is implemented on storyboard
    
    // Test out a DawnUser (This is a global that can be accessed throughout program
    currentUser = [[DawnUser alloc] init];
    
    DawnAlarm *alarm1 = [[DawnAlarm alloc] init];
    alarm1.name = @"Test Alarm";
    
    DawnAlarm *alarm2 = [[DawnAlarm alloc] init];
    alarm2.name = @"Test Alarm 2";
    
    DawnAlarm *alarm3 = [[DawnAlarm alloc] init];
    alarm3.name = @"The User class works!";
    
    [currentUser addAlarm:alarm1];
    [currentUser addAlarm:alarm2];
    [currentUser addAlarm:alarm3];
    
    NSLog(@"User initialized!");
    
    //test if user is signed in
    if ([FBSDKAccessToken currentAccessToken]) {
        
        //Test Parse Local Datastore
        PFObject *PDawnUser = [PFObject objectWithClassName:@"DawnUser"];
        PDawnUser[@"userID"] = [FBSDKProfile currentProfile].userID;
        [PDawnUser pinInBackground];
        
        //Test interaction with Facebook
        NSLog(@"User's Name is %@", [FBSDKProfile currentProfile].name);
        NSLog(@"User's ID is %@", [FBSDKProfile currentProfile].userID);
        currentUser.name = [FBSDKProfile currentProfile].name;
        
        //Leave controller if signed in
        [self.EnterDawn sendActionsForControlEvents:UIControlEventTouchDown];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



// Possibly useful code for later... -Jack
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
