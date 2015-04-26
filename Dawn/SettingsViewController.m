//
//  SettingsViewController.m
//  Dawn
//
//  Created by Ben Leizman on 4/16/15.
//  Copyright (c) 2015 Dawnteam. All rights reserved.
//

#import "SettingsViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *NewsSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *SportsSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *RedditSwitch;

@end

@implementation SettingsViewController

- (void)loadView {
    [super loadView];
    
    DawnPreferences *mypreferences = currentUser.preferences;
    
    self.NewsSwitch.on = mypreferences.nyTimesNews;
    self.SportsSwitch.on = mypreferences.sportsNews;
    self.RedditSwitch.on = mypreferences.redditNews;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize fb button
    //FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    //[self.view addSubview:loginButton];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
- (void) prefSwitchChanged:(id)sender {
    UISwitch *oldSwitch = sender;
    DawnPreferences *mypreferences = currentUser.preferences;

    if (mypreferences.sportsnews.on)
        alarm.isOn = false;
    else alarm.isOn = true;
    NSLog( @"Alarm being printed is of the name %@", alarm.name);
    NSLog( @"The switch is now %@", alarm.isOn ? @"ON" : @"OFF" );
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
