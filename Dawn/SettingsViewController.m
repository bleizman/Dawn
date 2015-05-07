//
//  SettingsViewController.m
//  Dawn
//
//  Created by Ben Leizman on 4/16/15.
//  Copyright (c) 2015 Dawnteam. All rights reserved.
//

#import "SettingsViewController.h"
#import <Parse/Parse.h>

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *SportsSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *NewYorkTimesSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *RedditSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *WeatherSwitch;
@property (weak, nonatomic) IBOutlet UITextField *ZipCodeField;

@end

@implementation SettingsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.SportsSwitch.on = currentUser.preferences.sportsNews;
    self.NewYorkTimesSwitch.on = currentUser.preferences.nyTimesNews;
    self.RedditSwitch.on = currentUser.preferences.redditNews;
    self.WeatherSwitch.on = currentUser.preferences.weather;
    self.ZipCodeField.text = currentUser.preferences.zipCode;
    
    //Set tap to stop editing zipCode
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(DoneEditing)];
    [self.view addGestureRecognizer:tap];
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

- (IBAction)EnterZipCode:(id)sender {
    NSString *zcode = [(UITextField *)sender text];
    if(zcode.length == 5){
        currentUser.preferences.zipCode = zcode;
        
        //Check if zipcode exists in database
        PFQuery *query = [PFQuery queryWithClassName:@"Weather"];
        [query whereKey:@"zipcode" equalTo:zcode];
        NSArray* weatherarray = [query findObjects];
        
        //If it does not, add it!
        if ([weatherarray count] <= 0){
            NSLog(@"Zipcode does not exist in database");
            PFObject *weather = [PFObject objectWithClassName:@"Weather"];
            weather[@"zipcode"] = zcode;
            [weather saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    NSLog(@"Sucessfully saved zipcode to database!");
                } else {
                    NSLog(@"Error in saving zipcode to database.");
                }
            }];
        }
        else {
            NSLog(@"Zipcode already exists in database");
        }
    }
}

- (IBAction)DoneEditing {
    [self.ZipCodeField resignFirstResponder];
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
