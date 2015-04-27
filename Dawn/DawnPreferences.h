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
@property BOOL nyTimesNews;
@property BOOL redditNews;
@property BOOL sportsNews;
@property BOOL scores;
//@property NSSet *newssites;

- (id)initWithName:(NSString*) name;
- (DawnPreferences*)setDefault: (DawnPreferences*) prefs;

@end
