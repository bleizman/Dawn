//
//  GoodMorningViewController.h
//  Dawn
//
//  Created by Jack O'Brien on 4/23/15.
//  Copyright (c) 2015 Dawnteam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DawnUser.h"
#import "DawnAlarm.h"
#import "AppDelegate.h"

extern DawnAlarm *currentAlarm;

@interface GoodMorningViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *back;

@end