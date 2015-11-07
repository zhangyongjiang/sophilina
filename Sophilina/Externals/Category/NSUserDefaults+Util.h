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
//  NSUserDefaults+Util.h
//
//
//  Created by Kevin Zhang on 12/29/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface NSUserDefaults (Util)

+ (void)save:(NSObject*)obj forKey:(NSString*)key;
+ (id)get:(NSString*)key;
+ (void)remove:(NSString *)key;

+ (User *)savedUser;
+ (void)saveUser:(User*)user;
+ (void)deleteSavedUser;

+ (NSString*)savedEmail;
+ (void)saveEmail:(NSString*)email;
+ (NSString*)savedPassword;
+ (void)savePassword:(NSString*)password;
+ (void)removeSavedEmail;
+ (void)removeSavedPassword;

+ (NSString*)savedPushNotificationToken;
+ (void)savePushNotificationToken:(NSString*)token;

+(void)saveCartNumber:(NSInteger)cartNumber;
+(int)savedCartNumber;

@end
