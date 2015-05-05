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
    __block NSMutableString *builderText = [[NSMutableString alloc] init];
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
    
    if(![currentAlarm.notes  isEqual: @""])
        [builderText appendString:currentAlarm.notes];

    if(currentPrefs.weather)
        [builderText appendString:@"\nWeather:  \n78 and sunny! Woohoo!\n"];
    
    if(currentPrefs.nyTimesNews)
        [builderText appendString:@"\nNews:  \nJack O'Brien Elected President!\n"];
    
    if(currentPrefs.sportsNews)
        [builderText appendString:@"\nSports:  \nBen Leizman wins Olympic Gold!\n"];
    
    if(currentPrefs.redditNews)
        [builderText appendString:@"\nReddit:  \nLOL OMG FUNNY INTERNET!\n"];
    
    //Test interaction with database
    [builderText appendString:@"\nFromDatabase:\n"];
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"ThePrince"];
    [query getObjectInBackgroundWithId:@"L4rZ5s286Y" block:^(PFObject *headline, NSError *error) {
        // Do something with the returned PFObject in the headline variable.
        
        NSString *myheadline = headline[@"Text"];
        
        NSLog(@"builder so far:%@:", builderText);

        [builderText appendString:myheadline];
        
        NSLog(@"builder after far:%@:", builderText);
        
        NSLog(@"Returned from the Database! :%@:", myheadline);
    }];

    [builderText appendString:@"\n\nYour dawn has come, start the day!"];
    
    return builderText;
}

- (void)loadView {
    [super loadView];
    NSLog(@"The Name of the current Alarm is: %@ .",currentAlarm.name);
    self.GoodMorningText.text = [self goodMorningTextBuilder];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
