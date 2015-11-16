//
//  ShippingDestination.m
//  ishopping
//
//  Created by Kevin Zhang on 5/25/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "UnitedStatesCities.h"

static NSMutableDictionary* gStateCityMap;
static NSMutableArray* gStates;

@implementation UnitedStatesCities

+(void)load {
    gStateCityMap = [[NSMutableDictionary alloc] init];
    gStates = [[NSMutableArray alloc] init];
    NSString *content = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"us-cities" ofType:@"tsv"] encoding:NSUTF8StringEncoding error:nil];
    NSArray* lines = [content componentsSeparatedByString:@"\n"];
    for (NSString* line in lines) {
        if ([line trim].length == 0) {
            continue;
        }
        NSRange range = [line rangeOfString:@"\t"];
        if(range.location == NSNotFound) {
            continue;
        }
        NSString* value = [line substringFromIndex:range.location+1];
        NSString* key = [line substringToIndex:range.location];
        NSMutableArray* states = [gStateCityMap objectForKey:key];
        if (!states) {
            states = [[NSMutableArray alloc] init];
            [gStateCityMap setObject:states forKey:key];
        }
        [states addObject:value];
        
        if (![gStates containsObject:key]) {
            [gStates addObject:key];
        }
    }
}

+(NSMutableArray*) getStates {
    return gStates;
}

+(NSMutableArray*) getCities:(NSString*)state {
    return [gStateCityMap objectForKey:state];
}
@end
