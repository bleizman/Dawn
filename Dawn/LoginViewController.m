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
    
    // I define archivepath in AppDelegate.m
    NSLog(@"%@", archivepath);
    
    // If file exists, load user. Else create new
    if ( [[NSFileManager defaultManager] fileExistsAtPath:archivepath]) {
        //load user
        currentUser = [NSKeyedUnarchiver unarchiveObjectWithFile:archivepath];
        NSMutableArray *alarms = currentUser.myAlarms;
        for (DawnAlarm *a in alarms) {
            NSLog(@"%@", a.name);
        }
        NSLog(@"Loaded in data for the current user");
    }
    else{
        // create a new user
        currentUser = [[DawnUser alloc] init];
        NSLog(@"First time use, create a new user object");
    }
    
    // Do this if user already logged into Facebook
    if ([FBSDKAccessToken currentAccessToken]) {
        //Personalized Welcome
        NSString *welcome = @"Welcome back to Dawn, ";
        welcome = [welcome stringByAppendingString:[FBSDKProfile currentProfile].firstName];
        self.WelcomeLabel.text = welcome;
        self.WelcomeLabel.adjustsFontSizeToFitWidth = YES;
            
        //Test interaction with Facebook
        NSLog(@"User's Name is %@", [FBSDKProfile currentProfile].name);
        NSLog(@"User's ID is %@", [FBSDKProfile currentProfile].userID);
        if (currentUser.name == nil) {
            currentUser.name = [FBSDKProfile currentProfile].name;
        }
        
        //Leave controller if signed in
        [self.EnterDawn sendActionsForControlEvents:UIControlEventTouchDown];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

@end
