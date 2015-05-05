//
//  NewAlarmViewController.m
//  Dawn
//
//  Created by Ben Leizman on 4/16/15.
//  Copyright (c) 2015 Dawnteam. All rights reserved.
//

#import "NewAlarmViewController.h"
#import "MyAlarmsTableViewController.h"
#import "DawnUser.h"
#import "CreatedAlarmViewController.h"

@interface NewAlarmViewController ()

@property int badgeCount;

@end

@implementation NewAlarmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _badgeCount = 0;
    NSLog(@"Default number is %d", currentUser.defaultNumber);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)unwindToNewAlarm:(UIStoryboardSegue *)segue {
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if (sender == _createNewAlarm) {
        
        NSLog(@"Should be adding a new alarm here!");
        NSDate *selectedDate = [_alarmDatePicker date];
        NSLog(@"The date is %@", selectedDate);
        NSString *name = [_alarmLabel text];
        if ([name isEqualToString:@""]) {
            name = [NSString stringWithFormat: @"Default Alarm %d", currentUser.defaultNumber];
            currentUser.defaultNumber++;
        }
        NSLog(@"The name is %@", name);
        
        DawnAlarm *newAlarm =[[DawnAlarm alloc] init];
        newAlarm = [newAlarm initWithName:name andDate:selectedDate andPrefs:currentUser.preferences];
        [currentUser.myAlarms addObject:newAlarm];
        NSLog(@"Initialized with the following preferences ");
        [newAlarm.prefs printPreferences];
        NSNumber *maxSnooze = newAlarm.prefs.maxSnooze;
        NSNumber *snoozeMins = newAlarm.prefs.snoozeMins;
        
        NSLog(@"but now the maxSnooze is %d", [newAlarm.prefs.snoozeMins intValue]);
        [CreatedAlarmViewController setText:newAlarm];
        
        [alarmTable reloadData];
        //NSDictionary *dict = [NSDictionary dictionaryWithObject:newAlarm forKey:@"alarm"];
        
        NSString* actionText = @"Morning Report";
        
        //create data from alarm object
        NSMutableData *data = [NSMutableData new];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        [newAlarm encodeWithCoder:archiver];
        [archiver finishEncoding];
        
        //create an NSDictionary that contains the alarmobj
        NSDictionary *alarmDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                   data, @"alarmData",
                                   snoozeMins, @"snoozeMins",
                                   maxSnooze, @"maxSnooze",
                                   nil];
        
        NSLog(@"The maxSnooze we're putting in is %d", [newAlarm.prefs.snoozeMins intValue]);
        
        //create a notification for that alarm
        [self scheduleNotificationOn:selectedDate text:name action:actionText sound:nil launchImage:nil andInfo:alarmDict];

    }
}

- (void) scheduleNotificationOn:(NSDate*) fireDate
                           text:(NSString*) alertText
                         action:(NSString*) alertAction
                          sound:(NSString*) soundfileName
                    launchImage:(NSString*) launchImage
                        andInfo:(NSDictionary*) userInfo

{
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = fireDate;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    
    localNotification.alertBody = alertText;
    localNotification.alertAction = alertAction;
    
    if(soundfileName == nil)
        localNotification.soundName =UILocalNotificationDefaultSoundName;
    else
    {
        localNotification.soundName = soundfileName;
    }
    
    localNotification.alertLaunchImage = launchImage;
    
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    localNotification.userInfo = userInfo;
        
    // Schedule it with the app
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    //[localNotification release];
}

@end
