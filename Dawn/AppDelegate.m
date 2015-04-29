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

@interface AppDelegate ()

@property BOOL isBackground;
@property GoodMorningViewController* goodMornVC;

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
        //DawnAlarm *alarm = [notif.userInfo objectForKey:@"Alarm"];
        
        //Use the alarm to take you to the Good Morning page
        /*[self.window.rootViewController presentViewController:_goodMornVC animated:FALSE completion:nil];*/
        
        application.applicationIconBadgeNumber = 0; // To decrease by 1 -> notif.applicationIconBadgeNumber-1;
    }
    
    /*[_window addSubview:_goodMornVC.view];
    [_window makeKeyAndVisible];*/
    
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
    
    // set the goodMornVC
    _goodMornVC = GoodMorningViewController.self;
    
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

//handle pushing an alert if in the background
- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification
{
    UIApplicationState state = [application applicationState];
    if (state == UIApplicationStateActive) {
        //need to cancel the local notification that was sent
        NSLog(@"Getting an alert while in the app");
        //[[UIApplication sharedApplication]cancelAllLocalNotifications];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:notification.alertBody
                                                            message:@"This is an in app alert"
                                                           delegate:self cancelButtonTitle:@"Snooze"
                                                  otherButtonTitles:@"Morning Report", nil];
        
        [alertView show];
    }
    //show the good morning page
    /*[self.window.rootViewController presentViewController:_goodMornVC animated:FALSE completion:nil];*/
    
}

//Used for archiving
NSString* getPropertyListPath() {
    // use the Documents directory (preferred URL method)
    NSURL *documentDir = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    NSURL *plist = [documentDir URLByAppendingPathComponent:@"user.plist"];
    return plist.path;
}

@end
