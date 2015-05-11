//
//  AppDelegate.m
//  This should work now?
//
//  Created by Jack O'Brien on 4/5/15.
//  Copyright (c) 2015 Dawnteam. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "AppDelegate.h"
#import <Parse/Parse.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>
#import "DawnAlarm.h"
#import "GoodMorningViewController.h"
#import "AlarmMethods.h"

@interface AppDelegate ()

@property BOOL isBackground;
@property UILocalNotification *lastNotif;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    archivepath = getPropertyListPath();
    
    //if opening from a notification, go to correct page
    NSLog(@"Getting an alert while not in the app");
    UILocalNotification *notif =
    [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    
    // Override point for customization after application launch.
    if (notif) {
        // set the current alarm
        self.lastNotif = notif;
        currentAlarm = [AlarmMethods getAlarmFromNotif:notif];
        //delete the notification from the alarm's set
        [self deleteAlarmNotifFromAlarmNotifs:notif];
        
        application.applicationIconBadgeNumber = 0;
        [self goToGoodMorning];
    }
    
    //ask to send notifications
    UIUserNotificationType types = UIUserNotificationTypeBadge |
    UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    
    UIUserNotificationSettings *mySettings =
    [UIUserNotificationSettings settingsForTypes:types categories:nil];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    
    // setup AVAudioPlayer
    NSString *alarmMusicPath = [[NSBundle mainBundle] pathForResource:@"tiktokREAL" ofType:@"wav"];
    NSURL *alarmMusicURL = [NSURL fileURLWithPath:alarmMusicPath];
    NSError *error;
    alarmSoundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:alarmMusicURL error:&error];
    [alarmSoundPlayer setNumberOfLoops:1];   // Negative number means loop forever
    
    // enables easy local datastore
    [Parse enableLocalDatastore];
    
    // Initialize Parse with our specific database
    [Parse setApplicationId:@"6UGj805WGY30A3VO32OieUY1XyP7JvMBhrR5hajm"
                  clientKey:@"CNwJsnl5xu5eDHOy6S0lZ9HPy3hqRQRKFo9R5Hmq"];
    //[PFFacebookUtils initializeFacebookWithApplicationLaunchOptions:launchOptions];
    
    // Pre-load work for FB login
    [FBSDKLoginButton class];
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [NSKeyedArchiver archiveRootObject:currentUser toFile:archivepath];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    application.applicationIconBadgeNumber = 0;
    
    // Necissary for FB interface
    [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [NSKeyedArchiver archiveRootObject:currentUser toFile:archivepath];
}

//Facebook handler
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

- (void)dismissModalViewController {
    
    UIViewController *topRootViewController = self.window.rootViewController;
    while (topRootViewController.presentedViewController) {
        
        topRootViewController = topRootViewController.presentedViewController;
    }
    //[topRootViewController dismissModalViewControllerAnimated:YES ]; // <- deprecated, don't use
    [topRootViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)goToGoodMorning {
    
    //get navigation controller
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GoodMorningViewController *goodMornVC = [storyboard instantiateViewControllerWithIdentifier:@"goodMorning"];
    UIViewController *topRootViewController = self.window.rootViewController;
    while (topRootViewController.presentedViewController) {
        
        topRootViewController = topRootViewController.presentedViewController;
    }
    
    [topRootViewController presentViewController:goodMornVC animated:YES completion:^{
        
        [goodMornVC.back addTarget:self action:@selector(dismissModalViewController) forControlEvents:UIControlEventTouchUpInside];
    }];
    
}

- (void) deleteAlarmNotifFromAlarmNotifs:(UILocalNotification*) notif {
    // if the alarm is a quick alarm, turn it off
    if (currentAlarm == nil) {
        NSLog(@"Alarm does not exist so nothing will be deleted");
        return;
    }
    else if ([currentAlarm.alarmType isEqualToString:@"quick"]) {
        //delete the alarm
        [AlarmMethods deleteAlarm:notif];
    }
    else { //advanced alarm
        // otherwise, delete the alarm notification
        // if it's a snooze notificaion, it won't be in the alarmNotif array, so nothing will change
        NSLog(@"currentAlarm.alarmNotifs BEFORE deleting the notificatin: \n");
        [currentAlarm printNotifs];
        NSLog(@"currentAlarm.alarmNotifs AFTER deleting the notificatin: \n");
        [currentAlarm printNotifs];
    }
}

- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    // stop sound
    if (alarmSoundIsPlaying == YES) {
        [alarmSoundPlayer stop];
        alarmSoundIsPlaying = NO;
    }
    
    //no more snoozes left
    if ([alertView numberOfButtons] == 1) {
        //delete the alarm
        [self deleteAlarmNotifFromAlarmNotifs:self.lastNotif];
        [self goToGoodMorning];
    }
    //snoozes left and choose to go to good morning page
    else if (buttonIndex == 1) {
        //delete the alarm
        [self deleteAlarmNotifFromAlarmNotifs:self.lastNotif];
        [self goToGoodMorning];
    }
    
    //snooze
    else {
        [AlarmMethods scheduleSnoozeNotificationWithLastNotification:self.lastNotif];
        // don't delete the alarm- only delete when go to good morning page
    }
}

//handle pushing an alert if in the foreground
- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification
{
    UIApplicationState state = [application applicationState];
    // set the current alarm
    self.lastNotif = notification;
    currentAlarm = [AlarmMethods getAlarmFromNotif:notification];
    if (state == UIApplicationStateActive) {
        NSLog(@"Getting an alert while in the app");
        
        //allocate space for alertView
        UIAlertView *alertView = [UIAlertView alloc];
        //if no more snoozes left, don't let snooze
        int intMaxSnooze = [[self.lastNotif.userInfo objectForKey:@"maxSnooze"] intValue];
        NSLog(@"Snoozes left is: %d", intMaxSnooze);
        if (intMaxSnooze == 0) {
            alertView = [alertView initWithTitle:notification.alertBody
                                         message:@"No more snoozes!"
                                        delegate:self cancelButtonTitle:nil
                               otherButtonTitles:@"Morning Report", nil];
        }
        else {
            NSString *message = [NSString stringWithFormat: @"In app alert, %@ snoozes left", [notification.userInfo objectForKey:@"maxSnooze"]];
            alertView = [alertView initWithTitle:notification.alertBody
                                         message: message
                                        delegate:self cancelButtonTitle:@"Snooze"
                               otherButtonTitles:@"Morning Report", nil];
        }
        [alertView show];
        application.applicationIconBadgeNumber = 0;
        
        // play the music
        [alarmSoundPlayer prepareToPlay];
        alarmSoundPlayer.currentTime = 0.0;
        [alarmSoundPlayer play];
        alarmSoundIsPlaying = YES;
        
    }
    
    // The app is running in the background (inactive state)
    else {
        //delete the notification from the alarm's set
        [self deleteAlarmNotifFromAlarmNotifs:notification];
        [self goToGoodMorning];
    }
}

//Used for archiving
NSString* getPropertyListPath() {
    // use the Documents directory (preferred URL method)
    NSURL *documentDir = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    NSURL *plist = [documentDir URLByAppendingPathComponent:@"user.plist"];
    return plist.path;
}

@end
