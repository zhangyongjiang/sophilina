//
//  ShippingDestination.h
//  ishopping
//
//  Created by Kevin Zhang on 5/25/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UnitedStatesCities : NSObject

+(NSMutableArray*) getStates;

+(NSMutableArray*) getCities:(NSString*)state;

@end
