//
//  SignupPage.h
//
//
//  Created by Kevin Zhang on 11/17/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "Page.h"

@interface ChangePasswordPage : FormPage

@property(strong, nonatomic)FullWidthPasswordFieldWithLabel* oldPasswordField;
@property(strong, nonatomic)FullWidthPasswordFieldWithLabel* passwordField;
@property(strong, nonatomic)FullWidthPasswordFieldWithLabel* confirmPasswordField;

@end
