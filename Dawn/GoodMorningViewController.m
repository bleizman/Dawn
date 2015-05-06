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
    PFObject *myObj;
    PFQuery *query;
    NSString *myString;
    
    NSMutableString *builderText = [[NSMutableString alloc] init];
    [builderText appendString:@"Good Morning!\n"];
    
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
    
    if(![currentAlarm.prefs.notes  isEqual: @""] && currentAlarm.prefs.notes != nil)
        [builderText appendString:currentAlarm.prefs.notes];

    if(currentPrefs.weather) {
        [builderText appendString:@"\nWeather:\n"];
        
        query = [PFQuery queryWithClassName:@"Weather"];
        [query whereKey:@"Zipcode" equalTo:@"08540"];
        NSArray* weatherarray = [query findObjects];
        
        if([weatherarray count] > 0){
        myObj = [weatherarray objectAtIndex: 0];
        myString = myObj[@"info"];
        if (![myString isEqualToString: nil]) {
            NSLog(@"%@", myString);
            [builderText appendString:myString];
        }
        }
        else {
            [builderText appendString:@"weather unavailable for your zipcode"];
        }
    }
    
    
    if(currentPrefs.nyTimesNews) {
        [builderText appendString:@"\n\nNews:\n"];
        
        query = [PFQuery queryWithClassName:@"News"];
        [query whereKey:@"Source" equalTo:@"NYTimes"];
        NSArray* newsarray = [query findObjects];
        
        if([newsarray count] > 0){
        myObj = [newsarray objectAtIndex: 0];
        myString = myObj[@"Text"];
        if (![myString isEqualToString: nil]) {
            NSLog(@"%@", myString);
            [builderText appendString:myString];
        }
        }
        else {
            [builderText appendString:@"News unavailable! Sorry!"];
        }
    }
    
    
    if(currentPrefs.sportsNews) {
        [builderText appendString:@"\n\nSports:\n"];
        
        query = [PFQuery queryWithClassName:@"Sports"];
        [query whereKey:@"Sport" equalTo:@"Test"];
        NSArray* sportsArray = [query findObjects];
        
        if([sportsArray count] > 0){
        myObj = [sportsArray objectAtIndex: 0];
        myString = myObj[@"Text"];
        if (![myString isEqualToString: nil]) {
            NSLog(@"%@", myString);
            [builderText appendString:myString];
        }
        }
        else {
            [builderText appendString:@"Sports unavailable! Sorry!"];
        }
    }
    
    if(currentPrefs.redditNews) {
        [builderText appendString:@"\n\nReddit:\n"];
        
        query = [PFQuery queryWithClassName:@"Reddit"];
        [query whereKey:@"Subject" equalTo:@"Funny!"];
        NSArray* redditarray = [query findObjects];
        
        if([redditarray count] > 0){
        myObj = [redditarray objectAtIndex: 0];
        myString = myObj[@"Text"];
        if (![myString isEqualToString: nil]) {
            NSLog(@"%@", myString);
            [builderText appendString:myString];
        }
        }
        else {
            [builderText appendString:@"Reddit unavailable! Sorry!"];
        }
    }
    
    //Test interaction with database...
    /*
    [builderText appendString:@"\nTEST: FromDatabase:\n"];
    
    query = [PFQuery queryWithClassName:@"ThePrince"];
    [query whereKey:@"Section" equalTo:@"Headline"];
    NSArray* scoreArray = [query findObjects];
    
    PFObject *myobject = [scoreArray objectAtIndex: 0];
    NSString *myheadline = myobject[@"Text"];
    if (![myheadline isEqualToString: nil]) {
        NSLog(@"%@", myheadline);
        [builderText appendString:myheadline];
    } */

    // Leave a nice message at the bottom
    [builderText appendString:@"\n\nYour dawn has come, start the day!"];
    
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
