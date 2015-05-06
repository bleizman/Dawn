//
//  DawnPreferences.h
//  Dawn
//
//  Created by Colter Smith on 4/13/15.
//  Copyright (c) 2015 Dawnteam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DawnPreferences : NSObject <NSCoding>

@property NSString *name;
@property BOOL weather;
@property BOOL snooze;
@property BOOL nyTimesNews;
@property BOOL redditNews;
@property BOOL sportsNews;
@property BOOL scores; //don't have implemented yet
@property NSString *zipCode;
@property NSNumber *snoozeMins;
@property NSNumber *maxSnooze;

@property NSString *notes;
@property NSMutableArray *repeatDays;
@property NSMutableArray *repeatWeeks;


//@property NSSet *newssites;

- (id)initWithName:(NSString*) name;
- (DawnPreferences*)setDefault: (DawnPreferences*) prefs;
- (void) printPreferences;

@end
