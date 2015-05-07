//
//  AdvancedSettings1ViewController.h
//  Dawn
//
//  Created by Ben Leizman on 4/16/15.
//  Copyright (c) 2015 Dawnteam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DawnPreferences.h"
#import "DawnUser.h"
#import "MyAlarmsTableViewController.h"
#import "NewAlarmViewController.h"


extern DawnUser *currentUser;
extern UITableView *alarmTable;
extern NSDate *selectedDate;
extern NSString *name;

@interface AdvancedSettings1ViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>

@end
