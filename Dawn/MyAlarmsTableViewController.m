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

@interface MyAlarmsTableViewController ()

@property (strong, nonatomic) IBOutlet UITableView *alarmsTable;

@end

@implementation MyAlarmsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myAlarms = [[NSMutableArray alloc] init];
    
    self.myAlarms = currentUser.myAlarms;
        
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
    return [self.myAlarms count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListPrototypeCell" forIndexPath:indexPath];
    
    alarmTable = tableView;
    
    DawnAlarm *alarmobj = [self.myAlarms objectAtIndex:indexPath.row];
    
    if (!alarmobj.isNew)
        return cell;
    
    cell.textLabel.text = alarmobj.name;
    
    UISwitch *mySwitch = [[UISwitch alloc] init];
    mySwitch.tag = indexPath.row;
    if (alarmobj.isOn)
        [mySwitch setOn:true];
    cell.accessoryView = mySwitch;
    
    [mySwitch addTarget:self action:@selector(alarmSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    
    alarmobj.isNew = false;
    return cell;
}

- (void) alarmSwitchChanged:(id)sender {
    UISwitch *oldSwitch = sender;
    DawnAlarm *alarm = [self.myAlarms objectAtIndex:oldSwitch.tag];
    if (alarm.isOn)
        alarm.isOn = false;
    else alarm.isOn = true;
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


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
 */


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

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
