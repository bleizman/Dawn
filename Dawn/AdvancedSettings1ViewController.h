//
//  AdvancedSettings1ViewController.h
//  Dawn
//
//  Created by Ben Leizman on 4/16/15.
//  Copyright (c) 2015 Dawnteam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvancedSettings1ViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UISwitch *weatherSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *snoozeSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *nytSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *redditSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *sportsSwitch;
@property (weak, nonatomic) IBOutlet UITextField *zipField;
@property (weak, nonatomic) IBOutlet UIPickerView *snoozeTimePicker;
@property (weak, nonatomic) IBOutlet UIPickerView *maxSnoozePicker;
@property (weak, nonatomic) IBOutlet UITextView *remindersTextView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *repeatDaysSegmentController;
@property (weak, nonatomic) IBOutlet UISegmentedControl *repeatWeekSegmentController;

@end
