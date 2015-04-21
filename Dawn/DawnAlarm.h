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

@interface DawnAlarm : NSObject

@property NSString *name;
@property NSDate *alarmTime;
@property NSString *Notes;
@property DawnPreferences *preferences;

- (id)initWithName:(NSString*) name andDate:(NSDate*) date;

@end
