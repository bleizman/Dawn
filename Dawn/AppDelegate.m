//
//  AppDelegate.m
//  This should work now?
//
//  Created by Jack O'Brien on 4/5/15.
//  Copyright (c) 2015 Dawnteam. All rights reserved.
//

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
        
        application.applicationIconBadgeNumber = 0;
        [self goToGoodMorning];
    }
    
    //ask to send notifications
    UIUserNotificationType types = UIUserNotificationTypeBadge |
    UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    
    UIUserNotificationSettings *mySettings =
    [UIUserNotificationSettings settingsForTypes:types categories:nil];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    
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
    
    //delete the alarm
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:[self.lastNotif.userInfo objectForKey:@"alarmData"]];
    currentAlarm = [[DawnAlarm alloc] initWithCoder:unarchiver];
    
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

- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    //no more snoozes left
    if ([alertView numberOfButtons] == 1) {
        //delete the alarm
        [AlarmMethods deleteAlarm:self.lastNotif];
        [self goToGoodMorning];
    }
    //snoozes left and choose to go to good morning page
    else if (buttonIndex == 1) {
        //delete the alarm
        [AlarmMethods deleteAlarm:self.lastNotif];
        [self goToGoodMorning];
    }
    
    //snooze
    else {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        [AlarmMethods scheduleSnoozeNotificationWithLastNotification:self.lastNotif];
    }
}

//handle pushing an alert if in the foreground
- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification
{
    UIApplicationState state = [application applicationState];
    self.lastNotif = notification;
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
        [application cancelAllLocalNotifications];
        [alertView show];
        //[deleteAlarm deleteAlarm:notification];
        application.applicationIconBadgeNumber = 0;
    }
    
    else {
        [AlarmMethods deleteAlarm:notification];
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
