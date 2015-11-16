//
//  SignupPage.m
//
//
//  Created by Kevin Zhang on 11/17/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "ChangePasswordPage.h"


@implementation ChangePasswordPage

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    self.oldPasswordField = [[FullWidthPasswordFieldWithLabel alloc] initWithLabel:@"Current"];
    [self.scrollView addSubview:self.oldPasswordField];
    self.oldPasswordField.y = FormTopMargin;
    
    self.passwordField = [[FullWidthPasswordFieldWithLabel alloc] initWithLabel:@"New Password"];
    self.passwordField.textField.placeholder = @"Min. 6 characters";
    [self.scrollView addSubview:self.passwordField];
    [self.passwordField belowView:self.oldPasswordField withMargin:FormFieldMargin];
    
    self.confirmPasswordField = [[FullWidthPasswordFieldWithLabel alloc] initWithLabel:@"Confirm"];
    [self.scrollView addSubview:self.confirmPasswordField];
    [self.confirmPasswordField belowView:self.passwordField withMargin:FormFieldMargin];
    
    UIView* containerView = [self maskViews:[NSArray arrayWithObjects:self.oldPasswordField, self.passwordField, self.confirmPasswordField, nil]];
    [self.scrollView addSubview:containerView];
    
    return self;
}

@end
