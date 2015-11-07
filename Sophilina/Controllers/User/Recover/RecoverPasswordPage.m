//
//  SignupPage.m
//
//
//  Created by Kevin Zhang on 11/17/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "RecoverPasswordPage.h"


@implementation RecoverPasswordPage

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    [self setBackgroundImage:@"signin-bg"];
//    [self show:@"animated-615x750" width:615 height:750 x:-50 y:0 toView:self.scrollView];
    self.headerLabel.text = @"Recover Password";
    
    self.forgotPasswordLabel = [[FitLabel alloc] init];
    self.forgotPasswordLabel.y = 100;
    self.forgotPasswordLabel.numberOfLines = 2;
    self.forgotPasswordLabel.textAlignment = NSTextAlignmentCenter;
    [self.forgotPasswordLabel styleContent];
    [self.forgotPasswordLabel white];
    self.forgotPasswordLabel.text = @"Please enter your email address below,\nwe will send a temp password to you.";
    [self.scrollView addSubview:self.forgotPasswordLabel];
    [self.forgotPasswordLabel hcenterInParent];
    
    self.emailField = [[FormTextField alloc] init];
    self.emailField.x = PagePadding;
    self.emailField.placeholder = @"Email";
    self.emailField.width = FullWidthExcludePadding;
    [self.emailField belowView:self.forgotPasswordLabel withMargin:20*[UIView scale]];
    [self.scrollView addSubview:self.emailField];
    
    UIView* containerView = [self maskViews:[NSArray arrayWithObject:self.emailField]];
    [self.scrollView addSubview:containerView];
    
    return self;
}

@end
