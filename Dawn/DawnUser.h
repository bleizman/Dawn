//
//  DawnUser.h
//  practicePrograms
//
//  Created by Jack O'Brien on 4/12/15.
//  Copyright (c) 2015 Dawnteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DawnAlarm.h"

@interface DawnUser : NSObject <NSCoding>

@property NSString *name;
@property NSString *userEmail;
@property NSString *preferences;
@property NSMutableArray *myAlarms;

// Initialize User with a Name
- (id)initWithName:(NSString*) name;

// Add a new Dawn alarm to the User's linked list of alarms
- (void) addAlarm:(DawnAlarm*) newAlarm;

// Delete an Alarm from the set
- (void) deleteAlarm:(DawnAlarm*) deleteAlarm;

@end
