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
    DawnAlarm *tbd = [AlarmMethods getAlarmFromNotif:notification];
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
    
    //delete the old notification from the alarm's notification array (as long as it's not the first) and add the new one
    DawnAlarm* alarmToChange = [AlarmMethods getAlarmFromNotif:lastNotif];
    NSLog(@"Current notifications in list BEFORE deletions are :");
    [alarmToChange printNotifs];
    NSLog(@"lastNotif has fireDate of %@", lastNotif.fireDate);
    
    //If not the first one, then delete the lastNotif
    if (!([alarmToChange.prefs.maxSnooze intValue] - ([newMaxSnooze intValue]+1))) {
        [alarmToChange.alarmNotifs removeObject:lastNotif];
        NSLog(@"Current notifications in list AFTER deletions and BEFORE adding are :");
        [alarmToChange printNotifs];
    }
    
    [alarmToChange.alarmNotifs addObject:localNotification];
    NSLog(@"Current notifications in list AFTER adding are :");
    [alarmToChange printNotifs];
}

+ (DawnAlarm *) getAlarmFromNotif:(UILocalNotification *) thisNotif {
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:[thisNotif.userInfo objectForKey:@"alarmData"]];
    DawnAlarm* newAlarm = [[DawnAlarm alloc] initWithCoder:unarchiver];
    for (DawnAlarm* a in currentUser.myAlarms) {
        if([a isEqual:newAlarm]) {
            newAlarm = a;
            NSLog(@"Found a match for the current alarm!");
            // if it's a snooze notificaion, it won't be in the alarmNotif array, so nothing will change
            return newAlarm;
        }
    }
    NSLog(@"No match found");
    return nil;
}

@end
