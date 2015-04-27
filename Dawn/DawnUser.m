//
//  DawnUser.m
//  practicePrograms
//
//  Created by Jack O'Brien on 4/12/15.
//  Copyright (c) 2015 Dawnteam. All rights reserved.
//

#import "DawnUser.h"

@implementation DawnUser


// attempting to save app data locally
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
        _defaultNumber = 1;
    }
    return self;
}

// simple initialization
- (id)init
{
    self = [super init];
    if (self) {
        self = [self initWithName:nil andEmail:@"lol@lol.com"];
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
        _preferences = [[DawnPreferences alloc] init];
        _myAlarms = [[NSMutableArray alloc] init];
        _defaultNumber = 1;
    }
    return self;
}

// Add a new Dawn alarm to the User's alarms
- (void) addAlarm:(DawnAlarm*) newAlarm
{
    [_myAlarms addObject: newAlarm];
}

// Delete an Alarm from the array
- (void) deleteAlarm:(DawnAlarm*) deleteThisAlarm
{
    // code here to delete alarm from the set
    [_myAlarms removeObject: deleteThisAlarm];
}


@end
