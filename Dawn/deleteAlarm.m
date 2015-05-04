//
//  deleteAlarm.m
//  Dawn
//
//  Created by Ben Leizman on 5/2/15.
//  Copyright (c) 2015 Dawnteam. All rights reserved.
//

#import "deleteAlarm.h"
#import "DawnAlarm.h"

@implementation deleteAlarm

// Delete an alarm from the myAlarms list and table view
+ (void)deleteAlarm:(UILocalNotification *)notification {
    
    //delete the alarm
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:[notification.userInfo objectForKey:@"alarmData"]];
    DawnAlarm *alarm = [DawnAlarm new];
    alarm = [alarm initWithCoder:unarchiver];
    DawnAlarm *tbd;
    
    for (DawnAlarm *identifier in currentUser.myAlarms) {
        NSLog(@"Does %@ match %@?", identifier, alarm);
        
        if ([identifier isEqual:alarm]) { //here isEqual means same hash value
            NSLog(@"They are equal");
            tbd = identifier;
            break;
        }
    }
    if (tbd != nil) {
        NSLog(@"Alarm %@ is being deleted", tbd.name);
        NSLog(@"Alarm has reference %@", tbd);
        NSLog(@"Current list of alarms is %@", currentUser.myAlarms);
        [currentUser deleteAlarm:tbd];
        [alarmTable reloadData];
        NSLog(@"Now, after deletion, list of alarms is %@", currentUser.myAlarms);
    }
    else NSLog(@"No alarm is being deleted");
}

@end
