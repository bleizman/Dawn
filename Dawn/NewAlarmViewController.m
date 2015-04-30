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

extern DawnUser *currentUser;

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
        newAlarm = [newAlarm initWithName:name andDate:selectedDate];
        [currentUser.myAlarms addObject:newAlarm];
        [CreatedAlarmViewController setText:newAlarm];
        
        [alarmTable reloadData];
        //NSDictionary *dict = [NSDictionary dictionaryWithObject:newAlarm forKey:@"alarm"];
        
        NSString* actionText = @"Morning Report";
        
        //create a notification for that alarm
        [self scheduleNotificationOn:selectedDate text:name action:actionText sound:nil launchImage:nil andInfo:nil];
        
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
    
    self.badgeCount ++;
    localNotification.applicationIconBadgeNumber = self.badgeCount;
    localNotification.userInfo = userInfo;
        
    // Schedule it with the app
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    //[localNotification release];
}

@end
