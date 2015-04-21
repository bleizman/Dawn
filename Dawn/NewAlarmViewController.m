//
//  NewAlarmViewController.m
//  Dawn
//
//  Created by Ben Leizman on 4/16/15.
//  Copyright (c) 2015 Dawnteam. All rights reserved.
//

#import "NewAlarmViewController.h"

#import "DawnUser.h"

extern DawnUser *currentUser;

@interface NewAlarmViewController ()
@property (weak, nonatomic) IBOutlet UITextField *alarmLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *alarmDatePicker;
@property (weak, nonatomic) IBOutlet UIButton *createNewAlarm;


@end

@implementation NewAlarmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
        
        NSDate *selected = [_alarmDatePicker date];
        NSString *name = [_alarmLabel text];
        DawnAlarm *newAlarm =[[DawnAlarm alloc] init];
        newAlarm = [newAlarm initWithName:name andDate:selected];
        
    }
}

@end
