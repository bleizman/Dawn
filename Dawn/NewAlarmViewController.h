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

@interface NewAlarmViewController : UIViewController

- (IBAction)unwindToNewAlarm:(UIStoryboardSegue *)segue;

@end
