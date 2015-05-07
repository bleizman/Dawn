//
//  AppDelegate.h
//  Dawn
//
//  Created by Jack O'Brien on 4/5/15.
//  Copyright (c) 2015 Dawnteam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "DawnUser.h"
#import "DawnAlarm.h"

extern DawnUser *currentUser;
extern UITableView *alarmTable;
NSString *archivepath;
DawnAlarm *currentAlarm;
AVAudioPlayer *alarmSoundPlayer;
BOOL alarmSoundIsPlaying;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end