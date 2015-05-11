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
        self = [self initWithName:@"default" andZip:@"08540"];
    }
    return self;
}

- (id)initWithName:(NSString*) name andZip:(NSString *) zip {
    self = [super init];
    if (self) {
        _name = name;
        _weather = YES;
        _snooze = YES;
        _nyTimesNews = YES;
        _redditNews = YES;
        _sportsNews = YES;
        _zipCode = zip;
        _maxSnooze = [NSNumber numberWithInt:3];
        _snoozeMins = [NSNumber numberWithInt:1];
        _notes = @"";
        _repeatDays = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                       [NSNumber numberWithBool:0], @"mon",
                       [NSNumber numberWithBool:0], @"tue",
                       [NSNumber numberWithBool:0], @"wed",
                       [NSNumber numberWithBool:0], @"thu",
                       [NSNumber numberWithBool:0], @"fri",
                       [NSNumber numberWithBool:0], @"sat",
                       [NSNumber numberWithBool:0], @"sun",
                       nil];
        /* Don't worry about this yet...
        //set the correct date
        if ([date compare:[NSDate date]] == NSOrderedAscending) { //then date is in the past
            // set date to the same time tomorrow
            date = [date dateByAddingTimeInterval:86400]; //86,400 seconds per day
        }
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEEE"];
        NSString *dayName = [dateFormatter stringFromDate:date];
        NSLog(@"The day name is %@", dayName);
        if (_repeatDays) */
        
        // must have same keys as keys on the segmented controller in storyboard
        _repeatWeeks = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                       [NSNumber numberWithBool:0], @"This week only", //one time alarm
                       [NSNumber numberWithBool:0], @"Every week",
                       [NSNumber numberWithBool:0], @"Every 2 weeks",
                       nil];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"pName"];
    [aCoder encodeBool:self.snooze forKey: @"pSnooze"];
    [aCoder encodeBool:self.weather forKey: @"pWeather"];
    [aCoder encodeBool:self.nyTimesNews forKey: @"pNews"];
    [aCoder encodeBool:self.redditNews forKey:@"pReddit"];
    [aCoder encodeBool:self.sportsNews forKey: @"pSports"];
    [aCoder encodeObject:self.maxSnooze forKey:@"pmaxSnooze"];
    [aCoder encodeObject:self.snoozeMins forKey:@"psnoozeMins"];
    [aCoder encodeObject:self.notes forKey:@"pNotes"];
    [aCoder encodeObject:self.zipCode forKey:@"pZip"];
    [aCoder encodeObject:self.repeatDays forKey:@"prepeatDays"];
    [aCoder encodeObject:self.repeatWeeks forKey:@"prepeatWeeks"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _name = [aDecoder decodeObjectForKey:@"pName"];
        _snooze = [aDecoder decodeBoolForKey:@"pSnooze"];
        _weather = [aDecoder decodeBoolForKey:@"pWeather"];
        _nyTimesNews = [aDecoder decodeBoolForKey:@"pNews"];
        _redditNews = [aDecoder decodeBoolForKey:@"pReddit"];
        _sportsNews = [aDecoder decodeBoolForKey:@"pSports"];
        _maxSnooze = [aDecoder decodeObjectForKey:@"pmaxSnooze"];
        _snoozeMins = [aDecoder decodeObjectForKey:@"psnoozeMins"];
        _notes = [aDecoder decodeObjectForKey:@"pNotes"];
        _zipCode = [aDecoder decodeObjectForKey:@"pZip"];
        _repeatDays = [aDecoder decodeObjectForKey:@"prepeatDays"];
        _repeatWeeks = [aDecoder decodeObjectForKey:@"prepeatWeeks"];
    }
    return self;
}

// I don't think we use this
// Isn't this the same as init with name?
/*- (DawnPreferences*)setDefault: (DawnPreferences*) prefs {

    prefs.weather = YES;
    return prefs;
}*/

- (void) printPreferences {
    NSLog(@"The alarm's preferences are as follows: ");
    NSLog(@"name is %@", self.name);
    NSLog(@"zip is %@", self.zipCode);
    NSLog(@"weather is %d", self.weather);
    NSLog(@"snooze is %d", self.snooze);
    NSLog(@"nyTimesNews is %d", self.nyTimesNews);
    NSLog(@"redditNews is %d", self.redditNews);
    NSLog(@"sportsNews is %d", self.sportsNews);
    NSLog(@"maxSnooze is %d", [self.maxSnooze intValue]);
    NSLog(@"snoozeMins is %d", [self.snoozeMins intValue]);
    NSLog(@"snoozeMins is %@", self.zipCode);
    NSLog(@"repeatDays are %@", self.repeatDays);
    NSLog(@"repeatWeeks are %@", self.repeatWeeks);
    NSLog(@"notes are %@", self.notes);
    
}

@end
