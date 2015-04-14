//
//  DawnUser.m
//  practicePrograms
//
//  Created by Jack O'Brien on 4/12/15.
//  Copyright (c) 2015 Dawnteam. All rights reserved.
//

#import "DawnUser.h"

@implementation DawnUser

- (id)init
{
    self = [super init];
    if (self) {
        self = [self initWithName:@"Jack O'Brien"];
    }
    return self;
}

// Initialize User with a Name
- (id)initWithName:(NSString*) name
{
    self = [super init];
    if (self) {
        _name = name;
        _userNumber = 0;
        _preferences = @"NONE";
    }
    return self;
}

// Add a new Dawn alarm to the User's linked list of alarms
- (void) addAlarm:(DawnAlarm*) newAlarm
{
    // code here to add an alarm to the pq
    int i = 4;
    i++;
}

- (void) deleteAlarm:(DawnAlarm*) deleteAlarm
{
    // code here to delete alarm from the pq
    int i = 4;
    i++;
}



@end
