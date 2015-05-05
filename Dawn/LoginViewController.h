//
//  LoginViewController.h
//  Dawn
//
//  Created by Ben Leizman on 4/16/15.
//  Copyright (c) 2015 Dawnteam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "DawnUser.h"

DawnUser *currentUser;
extern NSString *archivepath;

@interface LoginViewController : UIViewController

@property (nonatomic) IBOutlet UIButton *enterButton;

- (IBAction)enterButtonPressed:(id)sender;

@end
