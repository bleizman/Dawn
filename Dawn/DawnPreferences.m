//
//  DawnPreferences.m
//  Dawn
//
//  Created by Colter Smith on 4/13/15.
//  Copyright (c) 2015 Dawnteam. All rights reserved.
//

#import "DawnPreferences.h"

@implementation DawnPreferences

- (id)init{
    self = [super init];
    if (self) {
        self = [self initWithName:@"default"];
    }
    return self;
}


- (id)initWithName:(NSString*) name{
    self = [super init];
    if (self) {
        NSLog(@"self is true in the initWithMain message");
        _name = name;
        _weather = YES;
        _nyTimesNews = YES;
        _redditNews = YES;
        _sportsNews = YES;
        _scores = YES;
        _maxSnooze = [NSNumber numberWithInt:3];
        _snoozeMins = [NSNumber numberWithInt:1];
    }
    NSLog(@"Self is false in the initWithName method!!!");
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"pName"];
    [aCoder encodeBool:self.weather forKey: @"pWeather"];
    [aCoder encodeBool:self.nyTimesNews forKey: @"pNews"];
    [aCoder encodeBool:self.redditNews forKey:@"pReddit"];
    [aCoder encodeBool:self.sportsNews forKey: @"pSports"];
    [aCoder encodeBool:self.scores forKey: @"pScores"];
    [aCoder encodeObject:self.maxSnooze forKey:@"pmaxSnooze"];
    [aCoder encodeObject:self.snoozeMins forKey:@"psnoozeMins"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _name = [aDecoder decodeObjectForKey:@"pName"];
        _weather = [aDecoder decodeBoolForKey:@"pWeather"];
        _nyTimesNews = [aDecoder decodeBoolForKey:@"pNews"];
        _redditNews = [aDecoder decodeBoolForKey:@"pReddit"];
        _sportsNews = [aDecoder decodeBoolForKey:@"pSports"];
        _scores = [aDecoder decodeBoolForKey:@"pScores"];
        _maxSnooze = [aDecoder decodeObjectForKey:@"pmaxSnooze"];
        _snoozeMins = [aDecoder decodeObjectForKey:@"psnoozeMins"];
    }
    return self;
}


- (DawnPreferences*)setDefault: (DawnPreferences*) prefs {

    prefs.weather = YES;
    return prefs;
}

- (void) printPreferences {
    NSLog(@"The alarm's preferences are as follows: ");
    NSLog(@"name is %@", self.name);
    NSLog(@"weather is %d", self.weather);
    NSLog(@"nyTimesNews is %d", self.nyTimesNews);
    NSLog(@"redditNews is %d", self.redditNews);
    NSLog(@"sportsNews is %d", self.sportsNews);
    NSLog(@"scores is %d", self.scores);
    NSLog(@"maxSnooze is %d", [self.maxSnooze intValue]);
    NSLog(@"snoozeMins is %d", [self.snoozeMins intValue]);
}



@end
