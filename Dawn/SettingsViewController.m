//
//  SettingsViewController.m
//  Dawn
//
//  Created by Ben Leizman on 4/16/15.
//  Copyright (c) 2015 Dawnteam. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *SportsSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *NewYorkTimesSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *RedditSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *WeatherSwitch;

@end

@implementation SettingsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.SportsSwitch.on = currentUser.preferences.sportsNews;
    self.NewYorkTimesSwitch.on = currentUser.preferences.nyTimesNews;
    self.RedditSwitch.on = currentUser.preferences.redditNews;
    self.WeatherSwitch.on = currentUser.preferences.weather;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SwitchSports:(id)sender {
    UISwitch *sportsSwitch = (UISwitch *)sender;
    if([sportsSwitch isOn])
    {
        currentUser.preferences.sportsNews = YES;
    }
    else
    {
        currentUser.preferences.sportsNews = NO;
    }
}

- (IBAction)SwitchNewYorkTimes:(id)sender {
    UISwitch *newYorkTimesSwitch = (UISwitch *)sender;
    if([newYorkTimesSwitch isOn])
    {
        currentUser.preferences.nyTimesNews = YES;
    }
    else
    {
        currentUser.preferences.nyTimesNews = NO;
    }
}

- (IBAction)SwitchReddit:(id)sender {
    UISwitch *redditSwitch = (UISwitch *)sender;
    if([redditSwitch isOn])
    {
        currentUser.preferences.redditNews = YES;
    }
    else
    {
        currentUser.preferences.redditNews = NO;
    }
}

- (IBAction)SwitchWeather:(id)sender {
    UISwitch *weatherSwitch = (UISwitch *)sender;
    if([weatherSwitch isOn])
    {
        currentUser.preferences.weather = YES;
    }
    else
    {
        currentUser.preferences.weather = NO;
    }
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
