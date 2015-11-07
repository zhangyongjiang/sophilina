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
//  UITableViewCell+Util.m
//
//
//  Created by Kevin Zhang on 1/10/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "UITableViewCell+Util.h"

@implementation UITableViewCell (Util)

-(FitLabel*)addRightText:(NSString *)text {
    FitLabel* label = [[FitLabel alloc] init];
    [label styleTableViewRowContent];
    label.text = text;
    self.accessoryView = label;
    return label;
}

-(UISwitch*)addRightSwitch:(BOOL)on {
    UISwitch* s = [[UISwitch alloc] init];
    s.on = on;
    self.accessoryView = s;
    return s;
}

@end
