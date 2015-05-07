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
    [aCoder encodeObject:self.defaultNumber forKey:@"uNumber"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _name = [aDecoder decodeObjectForKey:@"uName"];
        _preferences = [aDecoder decodeObjectForKey:@"uPreferences"];
        _myAlarms = [aDecoder decodeObjectForKey:@"uAlarms"];
        _defaultNumber = [aDecoder decodeObjectForKey:@"uNumber"];
    }
    return self;
}

// simple initialization
- (id)init
{
    self = [super init];
    if (self) {
        self = [self initWithName:nil];
    }
    return self;
    
}


// Initialize User with a Name
- (id)initWithName:(NSString*) name;
{
    self = [super init];
    if (self) {
        _name = name;
        _preferences = [DawnPreferences new];
        _preferences = [self.preferences initWithName:@"User's Default Preferences" andZip:@"08540"];
        _myAlarms = [[NSMutableArray alloc] init];
        _defaultNumber = [NSNumber numberWithInt:0];
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
