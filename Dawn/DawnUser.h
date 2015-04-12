//
//  DawnUser.h
//  practicePrograms
//
//  Created by Jack O'Brien on 4/12/15.
//  Copyright (c) 2015 Dawnteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DawnAlarm.h"

@interface DawnUser : NSObject

@property NSString *name;
@property int userNumber;
@property NSString *preferences;
@property DawnAlarm *firstAlarm;

- (void) addAlarm:(DawnAlarm*) newAlarm;

@end
