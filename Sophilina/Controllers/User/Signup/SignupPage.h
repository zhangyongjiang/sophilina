//
//  SignupPage.h
//
//
//  Created by Kevin Zhang on 11/17/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//


@interface SignupPage : FormPage

@property(strong, nonatomic)FormTextField* firstNameField;
@property(strong, nonatomic)FormTextField* lastNameField;
@property(strong, nonatomic)FormTextField* emailField;
@property(strong, nonatomic)FormTextField* passwordField;
@property(strong, nonatomic)FormTextField* genderField;
@property(strong, nonatomic)UserImageView* userImgView;
@property(strong, nonatomic)FitLabel* clickToUploadLabel;
@property(strong, nonatomic)FitLabel* tosLabel;
@property(strong, nonatomic)FitLabel* policyLabel;
@property(strong, nonatomic)UIButton* signupBtn;

@property(strong, nonatomic)NSData *imageData;

@end
