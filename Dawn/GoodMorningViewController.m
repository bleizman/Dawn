//
//  GoodMorningViewController.m
//  Dawn
//
//  Created by Jack O'Brien on 4/23/15.
//  Copyright (c) 2015 Dawnteam. All rights reserved.
//

#import "GoodMorningViewController.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

@interface GoodMorningViewController ()
@property (weak, nonatomic) IBOutlet UITextView *GoodMorningText;

@end

@implementation GoodMorningViewController

-(NSString*)goodMorningTextBuilder {
    PFQuery *query;
    NSString *myString;
    
    NSMutableString *builderText = [[NSMutableString alloc] init];
    [builderText appendString:@"Welcome to the Good Morning Screen! Use this information to start your day!\n"];
    
    NSLog(@"Alarm is %@", currentAlarm.name);
    DawnPreferences *currentPrefs;
    
    if(currentAlarm != nil){
        currentPrefs = currentAlarm.prefs;
    }
    else{
        currentPrefs = currentUser.preferences;
        currentAlarm = [[DawnAlarm alloc] init];
        NSLog(@"currentAlarm is empty"); //for testing only
    }
    
    if(![currentAlarm.prefs.notes  isEqual: @""] && currentAlarm.prefs.notes != nil) {
        [builderText appendString:@"\n\nYou have the following notes for today:\n"];
        [builderText appendString:currentAlarm.prefs.notes];
    }
    
    
    if(currentPrefs.weather) {
        
        query = [PFQuery queryWithClassName:@"Weather"];
        [query whereKey:@"zipcode" equalTo:currentPrefs.zipCode];
        NSArray* weatherarray = [query findObjects];
        
        if([weatherarray count] > 0){
            
            PFObject *myWeather = [weatherarray objectAtIndex: 0];

            NSString *myWeatherString = [NSString stringWithFormat: @"\n\nThe Weather in %@:\nThe current temperature is %@ degrees. The current conditions are %@.\n", myWeather[@"info"], myWeather[@"temp"], myWeather[@"description"]];
            
            if([myWeatherString containsString:@"rain"] || [myWeatherString containsString:@"Rain"])
                myWeatherString = [myWeatherString stringByAppendingString:@"Chance of rain! Might want to bring a coat!\n"];
            
            [builderText appendString:myWeatherString];
        }
        else {
            [builderText appendString:@"\n\n Weather:\nSorry, Weather is unavailable for your zipcode. The database will update in 1 minute!\n"];
        }
    }
    
    
    if(currentPrefs.nyTimesNews) {
        [builderText appendString:@"\n\nNew York Times Top Stories:\n"];
        
        query = [PFQuery queryWithClassName:@"News"];
        NSArray* newsarray = [query findObjects];
    
        for (PFObject *news in newsarray) {
            myString = news[@"text"];
            
            if (myString != nil) {
                NSLog(@"%@", myString);
                [builderText appendString:@"-"];
                [builderText appendString:myString];
                [builderText appendString:@"\n   "];
                if (news[@"url"] != nil) {
                    NSString *url = news[@"url"];
                    [builderText appendString:url];
                    [builderText appendString:@"\n"];
                }
            }
        }
    }
    
    
    if(currentPrefs.sportsNews) {
        [builderText appendString:@"\n\nESPN News:\n"];
        
        query = [PFQuery queryWithClassName:@"Sports"];
        NSArray* sportsArray = [query findObjects];
        
        for (PFObject *sports in sportsArray) {
            
            myString = sports[@"text"];
            if (myString != nil) {
                NSLog(@"%@", myString);
                NSString *sport = sports[@"sport"];
                [builderText appendString:@"-"];
                [builderText appendString:sport];
                [builderText appendString:@": "];
                [builderText appendString:myString];
                [builderText appendString:@"\n   "];
                
                if (sports[@"url"] != nil) {
                    NSString *url = sports[@"url"];
                    [builderText appendString:url];
                    [builderText appendString:@"\n"];
                }
            }
        }
    }

    
    if(currentPrefs.redditNews) {
        [builderText appendString:@"\n\nGoodies from Reddit:\n"];
        
        query = [PFQuery queryWithClassName:@"Reddit"];
        NSArray* redditarray = [query findObjects];
        
        for (PFObject *rNews in redditarray) {
            
            myString = rNews[@"title"];
            if (myString != nil) {
                NSLog(@"%@", myString);
                [builderText appendString:@"-"];
                [builderText appendString:myString];
                [builderText appendString:@"\n   "];
                
                if (rNews[@"url"] != nil) {
                    NSString *url = rNews[@"url"];
                    [builderText appendString:url];
                    [builderText appendString:@"\n"];
                }
            }
        }
    }
    
    // nice message at the bottom
    [builderText appendString:@"\n\nYour dawn has come, go start the day!"];
    
    return builderText;
}

- (void)loadView {
    [super loadView];
    NSLog(@"The Name of the current Alarm is: %@ .",currentAlarm.name);
    self.GoodMorningText.text = @"Loading your personalized data...";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.GoodMorningText.text = [self goodMorningTextBuilder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
