//
//  LabelWithCaption.h
//
//
//  Created by Kevin Zhang on 1/17/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LabelWithCaption : UIView

@property(strong,nonatomic)NSString* text;
@property(strong,nonatomic)UILabel* labelCaption;
@property(strong,nonatomic)UILabel* labelText;

-(id)initWithCaption:(NSString*)caption;

@end
