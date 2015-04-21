//
//  DawnAlarm.m
//
//  Created by DawnTeam on 4/12/15.
//  Copyright (c) 2015 Dawnteam. All rights reserved.
//
//  A DawnAlarm has properties name, alarmtime, firstNote, preferences


#import "DawnAlarm.h"

@implementation DawnAlarm

// initialize without any knowledge of alarm
- (id)init
{
    self = [super init];
    if (self) {
        self = [self initWithName:@"Default Alarm" andDate:[NSDate date]];
    }
    return self;
}

// initialize with name and Date known
- (id)initWithName:(NSString*) name andDate:(NSDate*) date
{
    self = [super init];
    if (self) {
        _name = name;
        _alarmTime = date;
        _preferences = nil;
        _Notes = @"";
    }
    return self;
}

@end
