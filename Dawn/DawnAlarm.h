//
//  DawnAlarm.h
//  practicePrograms
//
//  Created by DawnTeam on 4/12/15.
//  Copyright (c) 2015 Dawnteam. All rights reserved.
//
//  A DawnAlarm has properties name, alarmtime, firstNote, preferences

#import <Foundation/Foundation.h>
#import "DawnPreferences.h"

@interface DawnAlarm : NSObject <NSCoding>

@property NSString *name;
@property NSDate *alarmTime;
@property NSString *notes;
@property BOOL snooze;
@property DawnPreferences *prefs;
@property BOOL isOn;
@property BOOL isNew; //don't think we need this but leaving it just in case

- (id)initWithName:(NSString*) name andDate:(NSDate*) date;
- (id)initWithCoder:(NSCoder *)aDecoder;

@end
