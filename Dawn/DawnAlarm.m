//
//  DawnAlarm.m
//
//  Created by DawnTeam on 4/12/15.
//  Copyright (c) 2015 Dawnteam. All rights reserved.
//
//  A DawnAlarm has properties name, alarmtime, firstNote, preferences

#import <UIKit/UIKit.h>
#import "DawnAlarm.h"
#import "DawnUser.h"

extern DawnUser *currentUser;

@implementation DawnAlarm

// initialize without any knowledge of alarm
 - (id)init
{
    self = [super init];
    if (self) {
        self = [self initWithName:@"Default Alarm" andTime:[NSDate date] andPrefs:[[DawnPreferences alloc]init] andType:@"quick"];
    }
    return self;
}

// initialize with Name, time, preferences, and type
- (id)initWithName:(NSString *)name andTime:(NSDate *)time andPrefs:(DawnPreferences *)prefs andType:(NSString *)type {
    self = [super init];
    if (self) {
        _name = name;
        _alarmTime = time;
        _isOn = true;
        _isNew = true;
        _prefs = prefs;
        _alarmNotifs = [[NSMutableSet alloc]init];
        _alarmType = type;
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
    [aCoder encodeObject:self.alarmType forKey:@"aType"];
    [aCoder encodeObject:self.alarmNotifs forKey:@"aNotifs"];
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
        _alarmType = [aDecoder decodeObjectForKey:@"aType"];
        _alarmNotifs = [aDecoder decodeObjectForKey:@"aNotifs"];
    }
    return self;
}

-(BOOL)isEqual:(id)object {
    DawnAlarm *that = object;
    if (![self.name isEqualToString:that.name]) return FALSE;
    else if (![self.alarmTime isEqualToDate:that.alarmTime]) return FALSE;
    else if (self.isOn != that.isOn) return FALSE;
    else if (self.isNew != that.isNew) return FALSE;
    else if (![self.alarmType isEqualToString:that.alarmType]) return FALSE;
    /*else if (![self.prefs isEqual:that.prefs]) return FALSE;*/
    else {
        NSLog(@"Names do match, returning true");
        return TRUE;
    }
}

- (void) printNotifs {
    int i;
    for (UILocalNotification *notif in self.alarmNotifs)
        
        NSLog(@"Alarm %d fires on %@", i, [notif.fireDate description]);
}

@end
