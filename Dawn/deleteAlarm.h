//
//  deleteAlarm.h
//  Dawn
//
//  Created by Ben Leizman on 5/2/15.
//  Copyright (c) 2015 Dawnteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DawnUser.h"
#import "MyAlarmsTableViewController.h"

extern UITableView *alarmTable;
extern DawnUser *currentUser;

@interface deleteAlarm : NSObject

+ (void)deleteAlarm:(UILocalNotification *)notification;

@end
