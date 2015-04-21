//
//  MyAlarmsTableViewController.h
//  Dawn
//
//  Created by Ben Leizman on 4/16/15.
//  Copyright (c) 2015 Dawnteam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DawnUser.h"

extern DawnUser *currentUser;

@interface MyAlarmsTableViewController : UITableViewController

@property NSMutableArray *myAlarms;

@end
