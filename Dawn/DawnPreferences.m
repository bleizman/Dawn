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
        _name = name;
        _weather = YES;
        _nyTimesNews = YES;
        _redditNews = YES;
        _sportsNews = YES;
        _scores = YES;
        _maxSnooze = [NSNumber numberWithInt:3];
        _snoozeMins = [NSNumber numberWithInt:1];
    }
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


@end
