//
//  CreatedAlarmViewController.m
//  Dawn
//
//  Created by Ben Leizman on 4/13/15.
//  Copyright (c) 2015 Dawnteam. All rights reserved.
//

#import "CreatedAlarmViewController.h"
#import "NewAlarmViewController.h"

@interface CreatedAlarmViewController ()

@end

@implementation CreatedAlarmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NewAlarmViewController *to = [segue destinationViewController];
    to.alarmLabel.text = @"";
    [to.alarmDatePicker setDate:[NSDate date] animated:YES];
    
    return;
}

@end
