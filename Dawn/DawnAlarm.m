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
        _notes = @"";
        _isOn = true;
        _isNew = true;
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"aName"];
    [aCoder encodeObject:self.alarmTime forKey:@"aTime"];
    [aCoder encodeObject:self.notes forKey:@"aNotes"];
    [aCoder encodeBool:self.isOn forKey: @"aisOn"];
    [aCoder encodeBool:self.isNew forKey: @"aisNew"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _name = [aDecoder decodeObjectForKey:@"aName"];
        _alarmTime = [aDecoder decodeObjectForKey:@"aTime"];
        _notes = [aDecoder decodeObjectForKey:@"aNotes"];
        _isOn = [aDecoder decodeBoolForKey:@"aisOn"];
        _isNew = [aDecoder decodeBoolForKey:@"aisNew"];
    }
    return self;
}

-(BOOL)isEqual:(id)object {
    DawnAlarm *that = object;
    if (![self.name isEqualToString:that.name]) {
        NSLog(@"Names don't match");
        return FALSE;
    }
    /*if (self.alarmTime != that.alarmTime) return FALSE;
    if (self.notes != that.notes) return FALSE;
    if (self.isOn != that.isOn) return FALSE;
    if (self.isNew != that.isNew) return FALSE;*/
    else {
        NSLog(@"Names do match, returning true");
        return TRUE;
    }
}

@end
