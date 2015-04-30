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
    NSMutableString *builderText = [[NSMutableString alloc] init];
    [builderText appendString:@"Good Morning!\n"];
    
    DawnPreferences *currentPreferences = currentUser.preferences;
    //currentAlarm *DawnAlarm = currentUser.myAlarms.first?
    
    //if(currentAlarm.notes != @"")
        [builderText appendString:@"\nTodays Notes: \nCall your mother!\nYou have a test at 4:00\nFeed the dog!\n"];

    if(currentPreferences.weather)
        [builderText appendString:@"\nWeather:  \n78 and sunny! Woohoo!\n"];
    
    if(currentPreferences.nyTimesNews)
        [builderText appendString:@"\nNews:  \nJack O'Brien Elected President!\n"];
    
    if(currentPreferences.sportsNews)
        [builderText appendString:@"\nSports:  \nBen Leizman wins Olympic Gold!\n"];
    
    if(currentPreferences.redditNews)
        [builderText appendString:@"\nReddit:  \nLOL OMG FUNNY INTERNET!\n"];
    
    //Test interaction with database
    [builderText appendString:@"\nFromDatabase:\n"];
    
    PFQuery *query = [PFQuery queryWithClassName:@"ThePrince"];
    [query getObjectInBackgroundWithId:@"L4rZ5s286Y" block:^(PFObject *headline, NSError *error) {
        // Do something with the returned PFObject in the headline variable.
        
        NSString *myheadline = headline[@"text"];
        
        [builderText appendString:myheadline];

        NSLog(@"%@", headline[@"Text"]);
    }];
    
    [builderText appendString:@"\n\nYour dawn has come, start the day!"];
    
    return builderText;
}

- (void)loadView {
    [super loadView];
    self.GoodMorningText.text = [self goodMorningTextBuilder];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Implement interaction with database?

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
