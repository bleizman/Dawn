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
    NSString *builderText = @"Good Morning!\n";
    
    //DawnPreferences *currentPreferences = currentUser.preferences;
    //currentAlarm *DawnAlarm = currentUser.myAlarms.first?
    
    //if(currentAlarm.notes != @"")
        builderText = [builderText stringByAppendingString:@"\nTodays Notes: \nCall your mother!\nYou have a test at 4:00\nFeed the dog!\n"];

    //if(currentPreferences.weather)
        builderText = [builderText stringByAppendingString:@"\nWeather:  \n78 and sunny! Woohoo!\n"];
    
    //if(currentPreferences.nyTimesNews)
        builderText = [builderText stringByAppendingString:@"\nNews:  \nJack O'Brien Elected President!\n"];
    
    //if(currentPreferences.sportsNews)
        builderText = [builderText stringByAppendingString:@"\nSports:  \nBen Leizman wins Olympic Gold!\n"];
    
    //if(currentPreferences.redditNews)
        builderText = [builderText stringByAppendingString:@"\nReddit:  \nLOL OMG FUNNY INTERNET!\n"];
    
    //Test interaction with database
    builderText = [builderText stringByAppendingString:@"\nFromDatabase:\n"];
    
    PFQuery *query = [PFQuery queryWithClassName:@"ThePrince"];
    [query getObjectInBackgroundWithId:@"L4rZ5s286Y" block:^(PFObject *headline, NSError *error) {
        // Do something with the returned PFObject in the headline variable.
        
        //NSString *headlineText = headline[@"text"];

        NSLog(@"%@", headline[@"Text"]);
    }];
    
    //builderText = [builderText stringByAppendingString:headlineText];

    
    builderText = [builderText stringByAppendingString:@"\n\nYour dawn has come, start the day!"];
    
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
