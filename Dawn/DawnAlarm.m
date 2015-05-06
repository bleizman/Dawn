//
//  DawnAlarm.m
//
//  Created by DawnTeam on 4/12/15.
//  Copyright (c) 2015 Dawnteam. All rights reserved.
//
//  A DawnAlarm has properties name, alarmtime, firstNote, preferences


#import "DawnAlarm.h"
#import "DawnUser.h"

extern DawnUser *currentUser;

@implementation DawnAlarm

// initialize without any knowledge of alarm
- (id)init
{
    self = [super init];
    if (self) {
        self = [self initWithName:@"Default Alarm" andDate:[NSDate date] andPrefs:[[DawnPreferences alloc]init]];
    }
    return self;
}

// initialize with Name, Date, and Default prefs
- (id)initWithName:(NSString*) name andDate:(NSDate*) date andPrefs: (DawnPreferences*) prefs
{
    self = [super init];
    if (self) {
        _name = name;
        _alarmTime = date;
        _isOn = true;
        _isNew = true;
        _prefs = prefs;
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"aName"];
    [aCoder encodeObject:self.alarmTime forKey:@"aTime"];
    [aCoder encodeBool:self.isOn forKey: @"aisOn"];
    [aCoder encodeBool:self.isNew forKey: @"aisNew"];
    [aCoder encodeObject:self.prefs forKey:@"aPrefs"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _name = [aDecoder decodeObjectForKey:@"aName"];
        _alarmTime = [aDecoder decodeObjectForKey:@"aTime"];
        _isOn = [aDecoder decodeBoolForKey:@"aisOn"];
        _isNew = [aDecoder decodeBoolForKey:@"aisNew"];
        _prefs = [aDecoder decodeObjectForKey:@"aPrefs"];
    }
    return self;
}

-(BOOL)isEqual:(id)object {
    DawnAlarm *that = object;
    if (![self.name isEqualToString:that.name]) {
        NSLog(@"Names don't match");
        return FALSE;
    }
    if (![self.alarmTime isEqualToDate:that.alarmTime]) return FALSE;
    if (self.isOn != that.isOn) return FALSE;
    if (self.isNew != that.isNew) return FALSE;
    else {
        NSLog(@"Names do match, returning true");
        return TRUE;
    }
}

@end
