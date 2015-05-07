//
//  AdvancedSettings1ViewController.m
//  Dawn
//
//  Created by Ben Leizman on 4/16/15.
//  Copyright (c) 2015 Dawnteam. All rights reserved.
//

#import "AdvancedSettings1ViewController.h"
#import "DawnPreferences.h"

DawnPreferences *prefs;

@interface AdvancedSettings1ViewController ()
{
    NSArray *_snoozeTimePickerData;
    NSArray *_maxSnoozePickerData;
    
}
@property __weak IBOutlet UIBarButtonItem *createAlarmButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *next1;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *next2;

@property (weak, nonatomic) IBOutlet UISwitch *weatherSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *snoozeSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *nytSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *redditSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *sportsSwitch;
@property (weak, nonatomic) IBOutlet UITextField *zipField;
@property (weak, nonatomic) IBOutlet UIPickerView *snoozeTimePicker;
@property (weak, nonatomic) IBOutlet UIPickerView *maxSnoozePicker;
@property (weak, nonatomic) IBOutlet UITextView *remindersTextView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *repeatWeekSegmentController;
@property (weak, nonatomic) IBOutlet UIButton *monButton;
@property (weak, nonatomic) IBOutlet UIButton *tueButton;
@property (weak, nonatomic) IBOutlet UIButton *wedButton;
@property (weak, nonatomic) IBOutlet UIButton *thuButton;
@property (weak, nonatomic) IBOutlet UIButton *friButton;
@property (weak, nonatomic) IBOutlet UIButton *satButton;
@property (weak, nonatomic) IBOutlet UIButton *sunButton;

@end

@implementation AdvancedSettings1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Yes, the viewDidLoad is being called every time");
    //initiliaze tap to get rid of gesture
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(DoneEditing)];
    [self.view addGestureRecognizer:tap];
    // Do any additional setup after loading the view.
    // Initialize Data
    _snoozeTimePickerData = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"12", @"15", @"20", @"30"];
    
    _maxSnoozePickerData = @[@"1", @"2", @"3", @"4", @"5", @"10"];
    
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

- (void) setToAdvancedPreferences1 {
    
    prefs.snooze = [self.snoozeSwitch isOn];
    NSLog(@"Snooze is %d", prefs.snooze);
    
    // Must convert snoozeMins/maxSnooze from String to NSNumber
    NSInteger row = [self.snoozeTimePicker selectedRowInComponent:0];
    NSString *snoozeMins = [self pickerView:self.snoozeTimePicker titleForRow:row forComponent:0];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    prefs.snoozeMins = [formatter numberFromString:snoozeMins];
    NSLog(@"snoozeMins is %d", [prefs.snoozeMins intValue]);
    
    row = [self.maxSnoozePicker selectedRowInComponent:0];
    NSString *maxSnooze = [self pickerView:self.maxSnoozePicker titleForRow:row forComponent:0];
    prefs.maxSnooze = [formatter numberFromString:maxSnooze];
    NSLog(@"maxSnooze is %d", [prefs.maxSnooze intValue]);
}

- (void) setToAdvancedPreferences2 {
    prefs.nyTimesNews = [self.nytSwitch isOn];
    NSLog(@"nyTimes is %d", prefs.nyTimesNews);
    prefs.redditNews = [self.redditSwitch isOn];
    NSLog(@"redditNews is %d", prefs.redditNews);
    prefs.sportsNews = [self.sportsSwitch isOn];
    NSLog(@"sportsNews is %d", prefs.sportsNews);
    prefs.weather = [self.weatherSwitch isOn];
    NSLog(@"weather is %d", prefs.weather);
    prefs.zipCode = [self.zipField text];
    NSLog(@"zipCode is %@", prefs.zipCode);
}

-(void) setToAdvancedPreferences3 {

    prefs.notes = [self.remindersTextView text];

    // Set dates to either selected or not selected
    // isSelected returns TRUE if selected, FALSE if not
    [prefs.repeatDays setObject:[NSNumber numberWithBool:[self.monButton isSelected]] forKey:@"mon"];
    [prefs.repeatDays setObject:[NSNumber numberWithBool:[self.tueButton isSelected]] forKey:@"tue"];
    [prefs.repeatDays setObject:[NSNumber numberWithBool:[self.wedButton isSelected]] forKey:@"wed"];
    [prefs.repeatDays setObject:[NSNumber numberWithBool:[self.thuButton isSelected]] forKey:@"thu"];
    [prefs.repeatDays setObject:[NSNumber numberWithBool:[self.friButton isSelected]] forKey:@"fri"];
    [prefs.repeatDays setObject:[NSNumber numberWithBool:[self.satButton isSelected]] forKey:@"sat"];
    [prefs.repeatDays setObject:[NSNumber numberWithBool:[self.sunButton isSelected]] forKey:@"sun"];
    
    // Set repeatWeek
    NSString *prefName = [self.repeatWeekSegmentController titleForSegmentAtIndex:self.repeatWeekSegmentController.selectedSegmentIndex];
    if ([prefName isEqualToString:@"This week only"]) {
        [prefs.repeatWeeks setObject:[NSNumber numberWithBool:TRUE] forKey:@"This week only"];
        [prefs.repeatWeeks setObject:[NSNumber numberWithBool:FALSE] forKey:@"Every week"];
        [prefs.repeatWeeks setObject:[NSNumber numberWithBool:FALSE] forKey:@"Every 2 weeks"];
    }
    if ([prefName isEqualToString:@"Every week"]) {
        [prefs.repeatWeeks setObject:[NSNumber numberWithBool:FALSE] forKey:@"This week only"];
        [prefs.repeatWeeks setObject:[NSNumber numberWithBool:TRUE] forKey:@"Every week"];
        [prefs.repeatWeeks setObject:[NSNumber numberWithBool:FALSE] forKey:@"Every 2 weeks"];
    }
    if ([prefName isEqualToString:@"Every 2 weeks"]) {
        [prefs.repeatWeeks setObject:[NSNumber numberWithBool:FALSE] forKey:@"This week only"];
        [prefs.repeatWeeks setObject:[NSNumber numberWithBool:FALSE] forKey:@"Every week"];
        [prefs.repeatWeeks setObject:[NSNumber numberWithBool:TRUE] forKey:@"Every 2 weeks"];
    }
}

- (IBAction)buttonTouchUpInside:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (button == self.monButton) {
        [self.monButton setSelected:![self.monButton isSelected]];
        NSLog(@"%@ is %d", self.monButton, [self.monButton isSelected]);
    }
    if (button == self.tueButton) {
        [self.tueButton setSelected:![self.tueButton isSelected]];
        NSLog(@"%@ is %d", self.tueButton, [self.tueButton isSelected]);
    }
    if (button == self.wedButton) {
        [self.wedButton setSelected:![self.wedButton isSelected]];
        NSLog(@"%@ is %d", self.wedButton, [self.wedButton isSelected]);
    }
    if (button == self.thuButton) {
        [self.thuButton setSelected:![self.thuButton isSelected]];
        NSLog(@"%@ is %d", self.thuButton, [self.thuButton isSelected]);
    }
    if (button == self.friButton) {
        [self.friButton setSelected:![self.friButton isSelected]];
        NSLog(@"%@ is %d", self.friButton, [self.friButton isSelected]);
    }
    if (button == self.satButton) {
        [self.satButton setSelected:![self.satButton isSelected]];
        NSLog(@"%@ is %d", self.satButton, [self.satButton isSelected]);
    }
    if (button == self.sunButton) {
        [self.sunButton setSelected:![self.sunButton isSelected]];
        NSLog(@"%@ is %d", self.sunButton, [self.sunButton isSelected]);
    }
}
- (IBAction)DoneEditing {
    [self.remindersTextView resignFirstResponder];
    [self.zipField resignFirstResponder];
}

- (IBAction)tappedReturn:(id)sender {
    [sender resignFirstResponder];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if (sender == self.next1) {
        // initialize and allocate preferences
        prefs = [[DawnPreferences alloc]init];
        
        [self setToAdvancedPreferences1];
        NSLog(@"We're hitting setToAdvancedPreferences1");
    }
    if (sender == self.next2) {
        [self setToAdvancedPreferences2];
        NSLog(@"We're hitting setToAdvancedPreferences2");
    }
    if (sender == self.createAlarmButton) {
        [self setToAdvancedPreferences3];
        [NewAlarmViewController setAlarmAndNotifwithPrefs:prefs];
    }
    
    
    
    // THIS IS A BUG BUT WILL ALWAYS SAVE THE ALARM (CAN'T CANCEL ALARM ONCE IT IS MADE)
    
    
}

@end
