//
//  DawnPreferences.h
//  Dawn
//
//  Created by Colter Smith on 4/13/15.
//  Copyright (c) 2015 Dawnteam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DawnPreferences : NSObject

@property NSString *name;

@property BOOL *weatheron;
@property NSInteger *zipcode;

@property BOOL *newson;
@property NSSet *newssites;

@property BOOL *sports;

- (id)initWithName:(NSString*) name;

@end
