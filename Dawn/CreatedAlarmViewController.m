//
//  CreatedAlarmViewController.m
//  Dawn
//
//  Created by Ben Leizman on 4/13/15.
//  Copyright (c) 2015 Dawnteam. All rights reserved.
//

#import "CreatedAlarmViewController.h"
#import "NewAlarmViewController.h"

static NSString* date;

@interface CreatedAlarmViewController ()
@property (weak, nonatomic) IBOutlet UITextView *alarmText;

@end

@implementation CreatedAlarmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.alarmText.text = [date description];
    self.alarmText.textAlignment = NSTextAlignmentCenter;
    
}

+ (void)setText:(DawnAlarm*) newAlarm {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeStyle = NSDateFormatterShortStyle;
    dateFormatter.dateStyle =NSDateFormatterMediumStyle;
    
    date = [dateFormatter stringFromDate:newAlarm.alarmTime];
    
    NSLog(@"Should be printing the date %@ here", [date description]);
    
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
