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
    __weak IBOutlet UITextView *remindersText;
    __weak IBOutlet UIBarButtonItem *createAlarmButton;
    
}
@end

@implementation AdvancedSettings1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //initiliaze tap to get rid of gesture
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(DoneEditing)];
    [self.view addGestureRecognizer:tap];
    // Do any additional setup after loading the view.
    // Initialize Data
    _snoozeTimePickerData = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"12", @"15", @"20", @"30"];
    
    _maxSnoozePickerData = @[@"0", @"1", @"2", @"3", @"4", @"5", @"∞"];
    
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

- (IBAction)DoneEditing {
    [remindersText resignFirstResponder];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
    // THIS IS A BUG BUT WILL ALWAYS SAVE THE ALARM (CAN'T CANCEL ALARM ONCE IT IS MADE
    
    
}

@end
