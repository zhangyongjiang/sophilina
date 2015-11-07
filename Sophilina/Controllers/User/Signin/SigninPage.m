//
//  SignupPage.m
//
//
//  Created by Kevin Zhang on 11/17/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "SigninPage.h"


@implementation SigninPage

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    [self setBackgroundImage:@"signin-bg"];
    
    
//    [self show:@"animated-500x620" width:500 height:620 x:0 y:0 toView:self.scrollView];
//    [self show:@"animated-800x540" width:800 height:540 x:0 y:0 toView:self.scrollView];
    
//    [self show:@"animated-615x346" width:615 height:346 x:-510 y:0 toView:self.scrollView];

//    [self show:@"animated-763x429" width:763 height:429 x:-300 y:0 toView:self.scrollView];
//    [self show:@"animated-615x750" width:615 height:750 x:-50 y:0 toView:self.scrollView];
//    [self show:@"animated-640x360" width:640 height:360 x:-450 y:0 toView:self.scrollView];
//    [self show:@"animated-615x355" width:615 height:355 x:-480 y:0 toView:self.scrollView];
//    [self show:@"animated-900x506" width:900 height:506 x:-100 y:0 toView:self.scrollView];
    
    
    self.headerLabel.text = @"Sign In";
    
    self.emailField = [[FormTextField alloc] init];
    self.emailField.accessibilityLabel = @"emailField";
    self.emailField.placeholder = @"Email";
    self.emailField.width = FullWidthExcludePadding;
    self.emailField.y = FormTopMargin;
    self.emailField.text = [NSUserDefaults savedEmail];
    [self.scrollView addSubview:self.emailField];
    
    self.passwordField = [[PasswordField alloc] init];
    self.passwordField.accessibilityLabel = @"passwordField";
    self.passwordField.placeholder = @"Password";
    self.passwordField.width = FullWidthExcludePadding;
    [self.scrollView addSubview:self.passwordField];
    
    self.forgotPasswordLabel = [[FitLabel alloc] init];
    self.forgotPasswordLabel.textAlignment = NSTextAlignmentCenter;
    [self.forgotPasswordLabel styleMenuItem];
    self.forgotPasswordLabel.text = @"Forgot your password?";
    self.forgotPasswordLabel.textColor = [UIColor whiteColor];
    [self.forgotPasswordLabel setUserInteractionEnabled:YES];
    [self.scrollView addSubview:self.forgotPasswordLabel];
    
    [UIView setLeftMargin:PagePadding views:self.emailField, self.passwordField, nil];
    [UIView top2bottomWithMargin:FormFieldMargin views:self.emailField, self.passwordField, nil];
    
    self.btnSignin = [self createActionButton:@"Go" image:nil bgcolr:[UIColor clearColor]];
    [self.btnSignin belowView:self.passwordField withMargin:24*[UIView scale]];
    
    [self.forgotPasswordLabel hcenterInParent];
    [self.forgotPasswordLabel belowView:self.passwordField withMargin:88*[UIView scale]];

    UIView* containerView = [self maskViews:[NSArray arrayWithObjects:self.emailField, self.passwordField, nil]];
    [self.scrollView addSubview:containerView];

    return self;
}


@end
