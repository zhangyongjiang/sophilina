//
//  OrderListEmptyView.m
//
//
//  Created by Kevin Zhang on 2/12/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "ProductListEmptyView.h"
#import "HomeViewController.h"

@implementation OrderListEmptyView

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    FitLabel* label = [[FitLabel alloc] init];
    [label h2];
    label.y = 114;
    label.text = @"You don't have any order yet";
    [self addSubview:label];
    [label hcenterInParent];
    
    UIImageView* imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"empty"]];
    [self addSubview:imgView];
    imgView.y = 164;
    [imgView hcenterInParent];
    
    NSButton* btn = [[NSButton alloc] initWithFrame:CGRectMake(0, 0, 180, 40)];
    [btn setTitle:@"Start Shopping" forState:UIControlStateNormal];
    [self addSubviewV:btn margin:60];
    [btn hcenterInParent];
    [btn addTarget:self action:@selector(startShopping)];
    
    return self;
}

-(void)startShopping {
    HomeViewController* controller = [[HomeViewController alloc] init];
    [[AppDelegate getInstance] startPage:controller];
}

@end
