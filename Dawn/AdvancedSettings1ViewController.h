//
//  AdvancedSettings1ViewController.h
//  Dawn
//
//  Created by Ben Leizman on 4/16/15.
//  Copyright (c) 2015 Dawnteam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvancedSettings1ViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *snoozeTimePicker;
@property (weak, nonatomic) IBOutlet UIPickerView *maxSnoozePicker;

- (IBAction)unwindToNewAlarm:(UIStoryboardSegue *)segue;

@end
