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
@property DawnPreferences *prefs;
@property BOOL isOn;
@property BOOL isNew; //don't think we need this but leaving it just in case
@property NSString *alarmType;
@property NSMutableSet *alarmNotifs;

// initialize with Name, Date, and Default prefs
- (id)initWithName:(NSString*) name andTime:(NSDate*) time andPrefs: (DawnPreferences*) prefs andType:(NSString*) type;

- (id)initWithCoder:(NSCoder *)aDecoder;

- (void) printNotifs;

@end
