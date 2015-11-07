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
//  UIImageView+Util.h
//
//
//  Created by Kevin Zhang on 1/3/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Util)

-(void)setImageWithPath:(NSString *)path;
-(void)setImageWithPath:(NSString *)path placeholderImage:(UIImage*)placeholderImage;
-(void)setImageWithPath:(NSString *)path  placeholderImage:(UIImage*)placeholderImage success:(void (^)(UIImage *image, UIImageView* view))success;
-(void)setImageWithPathArray:(NSArray*) array;
-(void)setImageWithPath:(NSString *)path andArray:(NSArray*) array;

@end
