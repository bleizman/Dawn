//
//  NewAlarmViewController.h
//  Dawn
//
//  Created by Ben Leizman on 4/16/15.
//  Copyright (c) 2015 Dawnteam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DawnUser.h"
#import "MyAlarmsTableViewController.h"

extern DawnUser *currentUser;
extern UITableView *alarmTable;
NSDate *selectedDate;
NSString *name;
UIDatePicker *datePicker;

@interface NewAlarmViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *alarmLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *alarmDatePicker;
@property (weak, nonatomic) IBOutlet UIButton *createNewAlarm;
@property (weak, nonatomic) IBOutlet UIButton *advancedSettingsButton;
@property (weak, nonatomic) IBOutlet UITextField *labelTextField;

- (IBAction)unwindToNewAlarm:(UIStoryboardSegue *)segue;
+ (void) addNotifs:(DawnAlarm*) newAlarm;

+ (UILocalNotification*) scheduleNotificationOn:(NSDate*) fireDate
                           text:(NSString*) alertText
                         action:(NSString*) alertAction
                          sound:(NSString*) soundfileName
                    launchImage:(NSString*) launchImage
                        andInfo:(NSDictionary*) userInfo
                 repeatInterval:(NSCalendarUnit) repeat;

+ (void) setAlarmAndNotifwithPrefs:(DawnPreferences *) prefs;


@end
