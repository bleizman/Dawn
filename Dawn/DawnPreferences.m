//
//  DawnPreferences.m
//  Dawn
//
//  Created by Colter Smith on 4/13/15.
//  Copyright (c) 2015 Dawnteam. All rights reserved.
//

#import "DawnPreferences.h"

@implementation DawnPreferences

- (id)init{
    self = [super init];
    if (self) {
        self = [self initWithName:@"default"];
    }
    return self;
}


- (id)initWithName:(NSString*) name{
    self = [super init];
    if (self) {
    _name = name;
    _weather = YES;
    _nyTimesNews = YES;
    _redditNews = YES;
    _sportsNews = YES;
    _scores = YES;
    }
    return self;
}


- (DawnPreferences*)setDefault: (DawnPreferences*) prefs {

    prefs.weather = YES;
    return prefs;
}


@end
