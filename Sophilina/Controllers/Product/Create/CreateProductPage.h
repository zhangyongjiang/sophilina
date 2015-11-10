//
//  SignupPage.h
//
//
//  Created by Kevin Zhang on 11/17/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "Page.h"

@interface CreateProductPage : FormPage

@property(strong, nonatomic)FormTextField* emailField;
@property(strong, nonatomic)FormTextField* passwordField;
@property(strong, nonatomic)FitLabel* forgotPasswordLabel;
@property(strong, nonatomic)UIButton* btnSignin;

@end
