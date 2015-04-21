//
//  DawnUser.m
//  practicePrograms
//
//  Created by Jack O'Brien on 4/12/15.
//  Copyright (c) 2015 Dawnteam. All rights reserved.
//

#import "DawnUser.h"

@implementation DawnUser

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"uName"];
    [aCoder encodeObject:self.preferences forKey:@"uPreferences"];
    [aCoder encodeObject:self.myAlarms forKey:@"uAlarms"];
    [aCoder encodeObject:self.userEmail forKey:@"uEmail"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _name = [aDecoder decodeObjectForKey:@"uName"];
        _preferences = [aDecoder decodeObjectForKey:@"uPreferences"];
        _myAlarms = [aDecoder decodeObjectForKey:@"uAlarms"];
        _userEmail = [aDecoder decodeObjectForKey:@"uEmail"];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        self = [self initWithName:@"Jack O'Brien" andEmail:@"fenwayob@gmail.com"];
    }
    return self;
    
}


// Initialize User with a Name
- (id)initWithName:(NSString*) name andEmail: (NSString*) email;
{
    self = [super init];
    if (self) {
        _name = name;
        _userEmail = email;
        _preferences = @"NO PREFERENCES";
        _myAlarms = [[NSMutableArray alloc] init];
    }
    return self;
}

// Add a new Dawn alarm to the User's linked list of alarms
- (void) addAlarm:(DawnAlarm*) newAlarm
{
    // code here to add an alarm to the set
    [_myAlarms addObject: newAlarm];
}

// Delete an Alarm from the set
- (void) deleteAlarm:(DawnAlarm*) deleteThisAlarm
{
    // code here to delete alarm from the set
    [_myAlarms removeObject: deleteThisAlarm];
}


@end
