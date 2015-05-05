//
//  AdvancedSettings1ViewController.m
//  Dawn
//
//  Created by Ben Leizman on 4/16/15.
//  Copyright (c) 2015 Dawnteam. All rights reserved.
//

#import "AdvancedSettings1ViewController.h"

@interface AdvancedSettings1ViewController ()
{
    NSArray *_snoozeTimePickerData;
    NSArray *_maxSnoozePickerData;
}
@end

@implementation AdvancedSettings1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Initialize Data
    _snoozeTimePickerData = @[@"1 Minute", @"2 Minutes", @"3 Minutes", @"4 Minutes", @"5 Minutes", @"6 Minutes", @"7 Minutes", @"8 Minutes", @"9 Minutes", @"10 Minutes", @"12 Minutes", @"15 Minutes", @"20 Minutes", @"25 Minutes", @"30 Minutes", @"45 Minutes", @"1 hour", @"2 hours"];
    
    _maxSnoozePickerData = @[@"∞", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12",];
    
    // Connect data
    self.snoozeTimePicker.dataSource = self;
    self.snoozeTimePicker.delegate = self;
    self.maxSnoozePicker.dataSource = self;
    self.maxSnoozePicker.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(pickerView == _snoozeTimePicker){
        return _snoozeTimePickerData.count;
    }
    else return _maxSnoozePickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(pickerView == _snoozeTimePicker)
        return _snoozeTimePickerData[row];
    else return _maxSnoozePickerData[row];
}
//Delete this unwindToNewAlarm when actually implementing!!!
- (IBAction)unwindToNewAlarm:(UIStoryboardSegue *)segue {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
