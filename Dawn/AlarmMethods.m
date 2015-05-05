//
//  deleteAlarm.m
//  Dawn
//
//  Created by Ben Leizman on 5/2/15.
//  Copyright (c) 2015 Dawnteam. All rights reserved.
//

#import "AlarmMethods.h"
#import "DawnAlarm.h"

@implementation AlarmMethods

// Delete an alarm from the myAlarms list and table view
+ (void)deleteAlarm:(UILocalNotification *)notification {
    
    //delete the alarm
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:[notification.userInfo objectForKey:@"alarmData"]];
    DawnAlarm *alarm = [DawnAlarm new];
    alarm = [alarm initWithCoder:unarchiver];
    [alarm.prefs printPreferences];
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

+ (void) scheduleSnoozeNotificationWithLastNotification:(UILocalNotification *) lastNotif {
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    // change fire date
    NSNumber *snoozeSeconds = [NSNumber numberWithInt:[[lastNotif.userInfo objectForKey:@"snoozeMins"] intValue]];
    NSLog(@"Snooze time is %d minutes", [snoozeSeconds intValue]);
    snoozeSeconds = [NSNumber numberWithInt:[snoozeSeconds intValue]*60]; //sets as seconds
    localNotification.fireDate = [lastNotif.fireDate dateByAddingTimeInterval:[snoozeSeconds intValue]];
    
    // set other notification items
    localNotification.timeZone = lastNotif.timeZone;
    localNotification.alertBody = lastNotif.alertBody;
    localNotification.alertAction = lastNotif.alertAction;
    localNotification.soundName = lastNotif.soundName;
    localNotification.alertLaunchImage = lastNotif.alertLaunchImage;
    //Don't think we want to change the iconBadgeNumber
    /*localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;*/
    
    // decrement max snooze
    NSNumber *newMaxSnooze = [NSNumber numberWithInt:[[lastNotif.userInfo objectForKey:@"maxSnooze"] intValue]-1];
    NSLog(@"Max snooze is now %d minutes", [newMaxSnooze intValue]);
    
    // make the new userInfo
    NSDictionary *newDict = [NSDictionary dictionaryWithObjectsAndKeys:
                               [lastNotif.userInfo objectForKey:@"alarmData"], @"alarmData",
                               [lastNotif.userInfo objectForKey:@"snoozeMins"], @"snoozeMins",
                               newMaxSnooze, @"maxSnooze",
                               nil];
    localNotification.userInfo = newDict;
    NSLog(@"localNotification now looks like this: %@, ", localNotification);
    
    // Schedule it with the app
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    //[localNotification release];
}

@end
