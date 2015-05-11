//
//  SettingsViewController.m
//  Dawn
//
//  Created by Ben Leizman on 4/16/15.
//  Copyright (c) 2015 Dawnteam. All rights reserved.
//

#import "SettingsViewController.h"
#import <Parse/Parse.h>

@interface SettingsViewController ()
{
    NSArray *_snoozeTimePickerData;
    NSArray *_maxSnoozePickerData;
}
@property (weak, nonatomic) IBOutlet UISwitch *SportsSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *NewYorkTimesSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *RedditSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *WeatherSwitch;
@property (weak, nonatomic) IBOutlet UITextField *ZipCodeField;
@property CGPoint originalCenter;
@property (weak, nonatomic) IBOutlet UIView *NewsView;
@property (weak, nonatomic) IBOutlet UIView *SnoozeView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *PanelSwitcher;
@property (weak, nonatomic) IBOutlet UIPickerView *snoozeTimePicker;
@property (weak, nonatomic) IBOutlet UIPickerView *maxSnoozePicker;
@property (weak, nonatomic) IBOutlet UISwitch *SnoozeSwitch;
@property (weak, nonatomic) IBOutlet UILabel *snoozeLengthLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxSnoozeLabel;
@property NSNumber *oldMaxSnooze;
@property NSNumber *oldSnoozeTime;

@end

@implementation SettingsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.SportsSwitch.on = currentUser.preferences.sportsNews;
    self.NewYorkTimesSwitch.on = currentUser.preferences.nyTimesNews;
    self.RedditSwitch.on = currentUser.preferences.redditNews;
    self.WeatherSwitch.on = currentUser.preferences.weather;
    self.ZipCodeField.text = currentUser.preferences.zipCode;
    self.SnoozeSwitch.on = currentUser.preferences.snooze;
    
    //Set tap to stop editing zipCode
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(DoneEditing)];
    [self.view addGestureRecognizer:tap];
    
    self.originalCenter = self.view.center;
    
    self.SnoozeView.hidden = YES;
    
    // Do any additional setup after loading the view.
    // Initialize Data
    _snoozeTimePickerData = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"12", @"15", @"20", @"30"];
    
    _maxSnoozePickerData = @[@"1", @"2", @"3", @"4", @"5", @"10"];
    
    // Connect data to picker views
    self.snoozeTimePicker.dataSource = self;
    self.snoozeTimePicker.delegate = self;
    self.maxSnoozePicker.dataSource = self;
    self.maxSnoozePicker.delegate = self;
}



// The number of columns of data in picker view
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data in picker view
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(pickerView == _snoozeTimePicker){
        return _snoozeTimePickerData.count;
    }
    else return _maxSnoozePickerData.count;
}

// The data to return for the row and component (column) that's being passed in to picker view
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(pickerView == _snoozeTimePicker)
        return _snoozeTimePickerData[row];
    else return _maxSnoozePickerData[row];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SwitchSports:(id)sender {
    UISwitch *sportsSwitch = (UISwitch *)sender;
    if([sportsSwitch isOn])
    {
        currentUser.preferences.sportsNews = YES;
    }
    else
    {
        currentUser.preferences.sportsNews = NO;
    }
}

- (IBAction)SwitchNewYorkTimes:(id)sender {
    UISwitch *newYorkTimesSwitch = (UISwitch *)sender;
    if([newYorkTimesSwitch isOn])
    {
        currentUser.preferences.nyTimesNews = YES;
    }
    else
    {
        currentUser.preferences.nyTimesNews = NO;
    }
}

- (IBAction)SwitchReddit:(id)sender {
    UISwitch *redditSwitch = (UISwitch *)sender;
    if([redditSwitch isOn])
    {
        currentUser.preferences.redditNews = YES;
    }
    else
    {
        currentUser.preferences.redditNews = NO;
    }
}

- (IBAction)SwitchSnooze:(id)sender {
    UISwitch *snoozeSwitch = (UISwitch *)sender;
    if([snoozeSwitch isOn])
    {
        currentUser.preferences.snooze = YES;
        self.snoozeLengthLabel.hidden = NO;
        self.maxSnoozeLabel.hidden = NO;
        self.snoozeTimePicker.hidden = NO;
        self.maxSnoozePicker.hidden = NO;
        currentUser.preferences.maxSnooze = self.oldMaxSnooze;
        currentUser.preferences.snoozeMins = self.oldSnoozeTime;
    }
    else
    {
        currentUser.preferences.snooze = NO;
        self.snoozeLengthLabel.hidden = YES;
        self.maxSnoozeLabel.hidden = YES;
        self.snoozeTimePicker.hidden = YES;
        self.maxSnoozePicker.hidden = YES;
        self.oldMaxSnooze = currentUser.preferences.maxSnooze;
        self.oldSnoozeTime = currentUser.preferences.snoozeMins;
        currentUser.preferences.snoozeMins = [NSNumber numberWithInt:0];
        currentUser.preferences.maxSnooze = [NSNumber numberWithInt:0];
    }
}

- (IBAction)SwitchWeather:(id)sender {
    UISwitch *weatherSwitch = (UISwitch *)sender;
    if([weatherSwitch isOn])
    {
        currentUser.preferences.weather = YES;
    }
    else
    {
        currentUser.preferences.weather = NO;
    }
}

- (IBAction)EnterZipCode:(id)sender {
    NSString *zcode = [(UITextField *)sender text];
    if(zcode.length == 5){
        currentUser.preferences.zipCode = zcode;
        
        //Check if zipcode exists in database
        PFQuery *query = [PFQuery queryWithClassName:@"Weather"];
        [query whereKey:@"zipcode" equalTo:zcode];
        NSArray* weatherarray = [query findObjects];
        
        //If it does not, add it!
        if ([weatherarray count] <= 0){
            NSLog(@"Zipcode does not exist in database");
            PFObject *weather = [PFObject objectWithClassName:@"Weather"];
            weather[@"zipcode"] = zcode;
            [weather saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    NSLog(@"Sucessfully saved zipcode to database!");
                } else {
                    NSLog(@"Error in saving zipcode to database.");
                }
            }];
        }
        else {
            NSLog(@"Zipcode already exists in database");
        }
    }
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView == self.snoozeTimePicker) {
        NSString *snoozeMins = [self pickerView:self.snoozeTimePicker titleForRow:row forComponent:0];
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        currentUser.preferences.snoozeMins = [formatter numberFromString:snoozeMins];
        NSLog(@"snoozeMins is %d", [currentUser.preferences.snoozeMins intValue]);
    }
    else if (pickerView == self.maxSnoozePicker) {
        NSString *maxSnooze = [self pickerView:self.maxSnoozePicker titleForRow:row forComponent:0];
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        currentUser.preferences.maxSnooze = [formatter numberFromString:maxSnooze];
        NSLog(@"maxSnooze is %d", [currentUser.preferences.maxSnooze intValue]);
    }
    else NSLog(@"Won't be here, if so, there's an issue");
}

- (IBAction)BeginEditZipCode:(id)sender {
    self.view.center = CGPointMake(self.originalCenter.x, self.originalCenter.y-150);
}

- (IBAction)EndEditZipCode:(id)sender {
    self.view.center = self.originalCenter;
}

- (IBAction)DoneEditing {
    [self.ZipCodeField resignFirstResponder];
}
- (IBAction)PanelSwitch:(id)sender {
    if(self.PanelSwitcher.selectedSegmentIndex == 0){
        self.NewsView.hidden = NO;
        self.SnoozeView.hidden = YES;
    }
    if(self.PanelSwitcher.selectedSegmentIndex == 1){
        self.NewsView.hidden = YES;
        self.SnoozeView.hidden = NO;
    }
    
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
