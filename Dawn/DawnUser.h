//
//  DawnUser.h
//  practicePrograms
//
//  Created by Jack O'Brien on 4/12/15.
//  Copyright (c) 2015 Dawnteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DawnAlarm.h"
#import "DawnPreferences.h"

@interface DawnUser : NSObject <NSCoding>

@property NSString *name;
@property DawnPreferences *preferences;
@property NSMutableArray *myAlarms;
@property NSNumber *defaultNumber;

// Initialize User with a Name
- (id)initWithName:(NSString*) name;

// Add a new Dawn alarm to the User's alarms
- (void) addAlarm:(DawnAlarm*) newAlarm;

// Delete an Alarm from the array
- (void) deleteAlarm:(DawnAlarm*) deleteAlarm;

@end
