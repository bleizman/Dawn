//
//  MyAlarmsTableViewController.m
//  Dawn
//
//  Created by Ben Leizman on 4/16/15.
//  Copyright (c) 2015 Dawnteam. All rights reserved.
//

#import "MyAlarmsTableViewController.h"
#import "DawnAlarm.h"
#import "DawnUser.h"
#import "AppDelegate.h"
#import "GoodMorningViewController.h"
#import "NewAlarmViewController.h"

@interface MyAlarmsTableViewController ()

@property (strong, nonatomic) IBOutlet UITableView *alarmsTable;

@end

@implementation MyAlarmsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set the edit button
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    alarmTable = self.alarmsTable;
    
    //self.myAlarms = [[NSMutableArray alloc] init];
    
    //self.myAlarms = currentUser.myAlarms;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [currentUser.myAlarms count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListPrototypeCell" forIndexPath:indexPath];
    
    alarmTable = tableView;
    
    DawnAlarm *alarmobj = [currentUser.myAlarms objectAtIndex:indexPath.row];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeStyle = NSDateFormatterShortStyle;
    NSString *myAlarmTime = [dateFormatter stringFromDate:alarmobj.alarmTime];
    
    NSString *AlarmText = [alarmobj.name stringByAppendingString:@", "];
    AlarmText = [AlarmText stringByAppendingString:myAlarmTime];
    
    cell.textLabel.text = AlarmText;
    
    UISwitch *mySwitch = [[UISwitch alloc] init];
    mySwitch.tag = indexPath.row;
    if (alarmobj.isOn)
        [mySwitch setOn:true];
    cell.accessoryView = mySwitch;
    
    [mySwitch addTarget:self action:@selector(alarmSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    
    return cell;
}

- (void) alarmSwitchChanged:(id)sender {
    UISwitch *oldSwitch = sender;
    DawnAlarm *alarm = [currentUser.myAlarms objectAtIndex:oldSwitch.tag];
    if (alarm.isOn) {
        alarm.isOn = false;
        // set turn delete all notifications for that alarm
        NSLog(@"Alarm notifs before deletion are :\n");
        [alarm printNotifs];
        for (UILocalNotification *notif in alarm.alarmNotifs) {
            NSLog(@"Notification to delete has firedate %@", notif.fireDate);
            [[UIApplication sharedApplication] cancelLocalNotification:notif];
        }
        [alarm.alarmNotifs removeAllObjects];
        NSLog(@"Alarm notifs after deletion are :\n");
        [alarm printNotifs];
    }
    else {
        alarm.isOn = true;
        // reset the notifcations for the turned-off alarm
        NSLog(@"Alarm notifs BEFORE addition are :\n");
        [alarm printNotifs];
        
        [NewAlarmViewController addNotifs:alarm];
        
        NSLog(@"Alarm notifs AFTER addition are :\n");
        [alarm printNotifs];
    }
    NSLog( @"Alarm being printed is of the name %@", alarm.name);
    NSLog( @"The switch is now %@", alarm.isOn ? @"ON" : @"OFF" );
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
 */


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        DawnAlarm *alarmobj = [currentUser.myAlarms objectAtIndex:indexPath.row];
        [currentUser deleteAlarm:alarmobj];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        NSLog(@"Deleted alarm entitled '%@'", alarmobj.name);
        NSLog(@"Alarms left are %@", currentUser.myAlarms.description);
    }
}

// Responds to the edit button
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [alarmTable setEditing:editing animated:YES];
}

// Shows the table in editing mode
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    //AppDelegate *controller = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return UITableViewCellEditingStyleDelete;
}

// States that the table can be reordered
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {

    return YES;
}

// Implements the reordering
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    DawnAlarm *alarm = [currentUser.myAlarms objectAtIndex:sourceIndexPath.row];
    [currentUser.myAlarms removeObjectAtIndex:sourceIndexPath.row];
    [currentUser.myAlarms insertObject:alarm atIndex:destinationIndexPath.row];
}

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
 */


/*#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

} */

@end
