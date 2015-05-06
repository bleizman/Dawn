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
    [builderText appendString:@"Good Morning! Here is some information to start your day!\n"];
    
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
        [builderText appendString:@"You left the following notes to yourself:\n"];
        [builderText appendString:currentAlarm.prefs.notes];
    }

    /*
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
    } */
    
    
    if(currentPrefs.nyTimesNews) {
        [builderText appendString:@"\n\nNews:\n"];
        
        query = [PFQuery queryWithClassName:@"News"];
        [query whereKey:@"Source" equalTo:@"NYTimes"];
        NSArray* newsarray = [query findObjects];
    
        for (PFObject *news in newsarray) {
            myString = news[@"Text"];
            
            //NSDate *timeretrieved = news[@"createdAt"];
            if (myString != nil) {
                NSLog(@"%@", myString);
                [builderText appendString:@"-"];
                [builderText appendString:myString];
                [builderText appendString:@"\n   "];
                [builderText appendString:news[@"Url"]];
                [builderText appendString:@"\n"];
            }
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
                [builderText appendString:@"-"];
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
        NSArray* redditarray = [query findObjects];
        
        for (PFObject *rNews in redditarray) {
           // NSDate *timeretrieved = rNews[@"createdAt"];
            
            myString = rNews[@"Title"];
            if (myString != nil) {
                NSLog(@"%@", myString);
                [builderText appendString:@"-"];
                [builderText appendString:myString];
                [builderText appendString:@"\n   "];
                
                if (rNews[@"Url"] != nil) {
                    NSString *url = rNews[@"Url"];
                    [builderText appendString:url];
                    [builderText appendString:@"\n"];
                }
            }
        }
    }
    
    for(int i = 0; i < 40; i++)
        [builderText appendString:@"This is a dumbline\n"];

    
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
