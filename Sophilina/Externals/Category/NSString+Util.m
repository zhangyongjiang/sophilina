/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

//
//  NSString+Util.m
//
//
//  Created by Kevin Zhang on 1/2/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "NSString+Util.h"

@implementation NSString (Util)

-(NSString*)trim {
    return [self stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
}

-(NSArray*)splitBy:(NSString *)str {
    return [self componentsSeparatedByString:str];
}

-(int)indexOf:(NSString *)substr {
    NSRange range = [self rangeOfString:substr];
    if (range.location == NSNotFound) {
        return -1;
    } else {
        return (int)range.location;
    }
}

-(NSUInteger)indexOf:(NSString *)searchString after:(int)pos {
    NSRange thisCharRange, searchCharRange;
    
    searchCharRange = NSMakeRange(pos, [self length]-pos);
    thisCharRange = [self rangeOfString:searchString options:0 range:searchCharRange];
    return thisCharRange.location;
}

-(NSString*)replaceFrom:(NSString*)from to:(NSString*)to with:(NSString*)with {
    int pos = [self indexOf:from];
    if (pos == -1) {
        return self;
    }
    int after = pos + [from length];
    NSInteger pos1 = [self indexOf:to after:after];
    NSString* newstr = [self stringByReplacingCharactersInRange:NSMakeRange(pos, pos1-pos) withString:with];
    return newstr;
}
@end
