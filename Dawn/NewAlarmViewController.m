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
#import "AdvancedSettings1ViewController.h"

long secInDay;
DawnAlarm* alarmToAdd;

@interface NewAlarmViewController ()

@end

@implementation NewAlarmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(DoneEditing)];
    [self.view addGestureRecognizer:tap];
    NSLog(@"Default number is %d", [currentUser.defaultNumber intValue]);
    secInDay = 86400; //The number of seconds in a day
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)unwindToNewAlarm:(UIStoryboardSegue *)segue {

}

- (void) setDate:(NSDate*) date andName:(NSString*) thisname {
    NSLog(@"Should be adding a new alarm here!");
    /* set alarm for tomorrow if you set an alarm in the past */
    if ([date compare:[NSDate date]] == -1) {
        NSLog(@"Changing the date to tomorrow, since date is in the past");
        date = [date dateByAddingTimeInterval:secInDay];
    }
    selectedDate = date;
    NSLog(@"The date is %@", selectedDate);
    name = thisname;
    if ([name isEqualToString:@""]) {
        name = [NSString stringWithFormat: @"Default Alarm %d", [currentUser.defaultNumber intValue]];
        currentUser.defaultNumber = [NSNumber numberWithInt:[currentUser.defaultNumber intValue] + 1];
    }
    NSLog(@"The name is %@", name);
}

+ (void) setAlarmAndNotifwithPrefs:(DawnPreferences *) prefs {
    
    DawnAlarm *newAlarm =[[DawnAlarm alloc] init];
    if (prefs == nil) {
        newAlarm = [newAlarm initWithName:name andTime:selectedDate andPrefs:currentUser.preferences andType:@"quick"];
    }
    else {
        newAlarm = [newAlarm initWithName:name andTime:selectedDate andPrefs:prefs andType:@"advanced"];
    }
    
    [currentUser addAlarm:newAlarm];
    NSLog(@"Initialized with the following preferences ");
    [newAlarm.prefs printPreferences];
    
    [CreatedAlarmViewController setText:newAlarm];
    [alarmTable reloadData];
    
    alarmToAdd = newAlarm;
    [self addNotifs:newAlarm];
    
}

+ (void) addNotifs:(DawnAlarm*) newAlarm {
    
    NSNumber *maxSnooze = newAlarm.prefs.maxSnooze;
    NSNumber *snoozeMins = newAlarm.prefs.snoozeMins;
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
    //create a notification for a quick alarm
    if ([newAlarm.alarmType isEqualToString:@"quick"]) {
        [NewAlarmViewController scheduleNotificationOn:selectedDate text:name action:actionText sound:@"tiktokREAL.wav" launchImage:nil andInfo:alarmDict repeatInterval:0];
        //0 signifies no repeat
    }
    
    else {
        // if you're editing an alarm after it would have gone off, reset to tomorrow
        /* set alarm for tomorrow if you set an alarm in the past */
        if ([selectedDate compare:[NSDate date]] == -1) {
            NSLog(@"Changing the date to tomorrow, since date is in the past");
            selectedDate = [selectedDate dateByAddingTimeInterval:secInDay];
        }
        
        //create notifications for alarms in the future (later in the week)
        NSCalendar *calendar = [NSCalendar currentCalendar]; // gets default calendar
        // get the hour and minute from the alarm, but get the year, month, and day from current date
        NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday) fromDate:[NSDate date]];
        NSDateComponents *timeComponents = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:selectedDate];
        long weekday = [components weekday];
        [components setHour:[timeComponents hour]];
        [components setMinute:[timeComponents minute]];
        NSDate* newDate = [calendar dateFromComponents:components];
        
        //set the repeat interval
        NSCalendarUnit calUnit = 0;
        if ([[newAlarm.prefs.repeatWeeks objectForKey:@"This week only"] intValue]) { //Has value of 1
            calUnit = 0;
            NSLog(@"Repeat interval = this week only");
        }
        else if ([[newAlarm.prefs.repeatWeeks objectForKey:@"Every week"] intValue]) { //Has value of 1
            calUnit = NSWeekCalendarUnit; //Change to NSCalendarUnitMinute for testing purposes
            NSLog(@"Repeat interval = every week");
        }
        //Should never hit here, because automatically starts with "This week only" selected
        else NSLog(@"There is an error!");
        
        //set alarms for each day that is selected
        if ([[newAlarm.prefs.repeatDays objectForKey:@"sun"] intValue]) { // means that sunday is set
            //set an alarm for next sunday
            long daysInFuture = weekday-1; //1 is Sunday
            if (daysInFuture < 0) daysInFuture += 7;
            NSDate *date = [newDate dateByAddingTimeInterval:(secInDay*daysInFuture)];
            UILocalNotification *newNotif = [NewAlarmViewController scheduleNotificationOn:date text:name action:actionText sound:@"tiktokREAL.wav" launchImage:nil andInfo:alarmDict repeatInterval:calUnit];
            [newAlarm.alarmNotifs addObject:newNotif];
            NSLog(@"Alarm is being added on date: %@", [date description]);
        }
        if ([[newAlarm.prefs.repeatDays objectForKey:@"mon"] intValue]) {
            //set an alarm for next monday
            long daysInFuture = weekday-2; //2 is Monday
            if (daysInFuture < 0) daysInFuture += 7;
            NSDate *date = [newDate dateByAddingTimeInterval:(secInDay*daysInFuture)];
            UILocalNotification *newNotif = [NewAlarmViewController scheduleNotificationOn:date text:name action:actionText sound:@"tiktokREAL.wav" launchImage:nil andInfo:alarmDict repeatInterval:calUnit];
            [newAlarm.alarmNotifs addObject:newNotif];
            NSLog(@"Alarm is being added on date: %@", [date description]);
        }
        if ([[newAlarm.prefs.repeatDays objectForKey:@"tue"] intValue]) {
            //set an alarm for next tuesday
            long daysInFuture = weekday-3; //3 is tuesday
            if (daysInFuture < 0) daysInFuture += 7;
            NSDate *date = [newDate dateByAddingTimeInterval:(secInDay*daysInFuture)];
            UILocalNotification *newNotif = [NewAlarmViewController scheduleNotificationOn:date text:name action:actionText sound:@"tiktokREAL.wav" launchImage:nil andInfo:alarmDict repeatInterval:calUnit];
            [newAlarm.alarmNotifs addObject:newNotif];
            NSLog(@"Alarm is being added on date: %@", [date description]);
        }
        if ([[newAlarm.prefs.repeatDays objectForKey:@"wed"] intValue]) {
            //set an alarm for next wednesday
            long daysInFuture = weekday-4; //4 is wednesday
            if (daysInFuture < 0) daysInFuture += 7;
            NSDate *date = [newDate dateByAddingTimeInterval:(secInDay*daysInFuture)];
            UILocalNotification *newNotif = [NewAlarmViewController scheduleNotificationOn:date text:name action:actionText sound:@"tiktokREAL.wav" launchImage:nil andInfo:alarmDict repeatInterval:calUnit];
            [newAlarm.alarmNotifs addObject:newNotif];
            NSLog(@"Alarm is being added on date: %@", [date description]);
        }
        if ([[newAlarm.prefs.repeatDays objectForKey:@"thu"] intValue]) {
            //set an alarm for next thursday
            long daysInFuture = weekday-5; //5 is thursday
            if (daysInFuture < 0) daysInFuture += 7;
            NSDate *date = [newDate dateByAddingTimeInterval:(secInDay*daysInFuture)];
            UILocalNotification *newNotif = [NewAlarmViewController scheduleNotificationOn:date text:name action:actionText sound:@"tiktokREAL.wav" launchImage:nil andInfo:alarmDict repeatInterval:calUnit];
            [newAlarm.alarmNotifs addObject:newNotif];
            NSLog(@"Alarm is being added on date: %@", [date description]);
        }
        if ([[newAlarm.prefs.repeatDays objectForKey:@"fri"] intValue]) {
            //set an alarm for next friday
            long daysInFuture = weekday-6; //6 is friday
            if (daysInFuture < 0) daysInFuture += 7;
            NSDate *date = [newDate dateByAddingTimeInterval:(secInDay*daysInFuture)];
            UILocalNotification *newNotif = [NewAlarmViewController scheduleNotificationOn:date text:name action:actionText sound:@"tiktokREAL.wav" launchImage:nil andInfo:alarmDict repeatInterval:calUnit];
            [newAlarm.alarmNotifs addObject:newNotif];
            NSLog(@"Alarm is being added on date: %@", [date description]);
        }
        if ([[newAlarm.prefs.repeatDays objectForKey:@"sat"] intValue]) {
            //set an alarm for next saturday
            long daysInFuture = weekday-7; //7 is saturday
            if (daysInFuture < 0) daysInFuture += 7;
            NSDate *date = [newDate dateByAddingTimeInterval:(secInDay*daysInFuture)];
            UILocalNotification *newNotif = [NewAlarmViewController scheduleNotificationOn:date text:name action:actionText sound:@"tiktokREAL.wav" launchImage:nil andInfo:alarmDict repeatInterval:calUnit];
            [newAlarm.alarmNotifs addObject:newNotif];
            NSLog(@"Alarm is being added on date: %@", [date description]);
        }
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if (sender == _createNewAlarm) {
        [self setDate:[_alarmDatePicker date] andName:[_alarmLabel text]];
        [NewAlarmViewController setAlarmAndNotifwithPrefs:nil];
    }
    
    else if (sender == _advancedSettingsButton) {
        [self setDate:[_alarmDatePicker date] andName:[_alarmLabel text]];
        // Advanced settings changes preferences to represent those in advanced settings
    }
}

+ (UILocalNotification*) scheduleNotificationOn:(NSDate*) fireDate
                                           text:(NSString*) alertText
                                         action:(NSString*) alertAction
                                          sound:(NSString*) soundfileName
                                    launchImage:(NSString*) launchImage
                                        andInfo:(NSDictionary*) userInfo
                                 repeatInterval:(NSCalendarUnit) repeat;

{
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = fireDate;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    
    localNotification.alertBody = alertText;
    localNotification.alertAction = alertAction;
    
    if(soundfileName == nil)
        localNotification.soundName = UILocalNotificationDefaultSoundName;
    else
    {
        localNotification.soundName = soundfileName;
    }
    NSLog(@"localNotification.soundName is %@", localNotification.soundName);
    
    localNotification.alertLaunchImage = launchImage;
    
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    localNotification.userInfo = userInfo;
    localNotification.repeatInterval = repeat;
    
    // Schedule it with the app
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    //[localNotification release];
    
    // Add local notification to the list
    NSLog(@"alarmToAdd.alarmNotifs BEFORE adding :");
    [alarmToAdd printNotifs];
    [alarmToAdd.alarmNotifs addObject:localNotification];
    NSLog(@"alarmToAdd.alarmNotifs AFTER adding :");
    [alarmToAdd printNotifs];
    
    return localNotification;
}

- (IBAction)DoneEditing {
    [self.labelTextField resignFirstResponder];
}
- (IBAction)TappedReturn:(id)sender {
    [sender resignFirstResponder];
}

@end
