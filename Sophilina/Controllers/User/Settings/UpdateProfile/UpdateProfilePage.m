//
//  SettingsPage.m
//
//
//  Created by Kevin Zhang on 11/19/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "UpdateProfilePage.h"

@interface UpdateProfilePage() <UIPickerViewDataSource, UIPickerViewDelegate>
@end

@implementation UpdateProfilePage

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    self.userImgView = [[LargeUserImageView alloc] init];
    self.userImgView.y = FormTopMargin;
    [self.scrollView addSubview:self.userImgView];
    [self.userImgView hcenterInParent];
    
    self.firstNameField = [[FullWidthTextFieldWithLabel alloc] initWithLabel:@"First Name"];
    [self.scrollView addSubviewV:self.firstNameField margin:30];
    
    self.lastNameField = [[FullWidthTextFieldWithLabel alloc] initWithLabel:@"Last Name"];
    [self.scrollView addSubview:self.lastNameField];
    [self.lastNameField belowView:self.firstNameField withMargin:FormFieldMargin];
    
    self.cityField = [[FullWidthTextFieldWithLabel alloc] initWithLabel:@"City"];
    [self.scrollView addSubview:self.cityField];
    [self.cityField belowView:self.lastNameField withMargin:FormFieldMargin];
    
    self.stateField = [[FullWidthTextFieldWithLabel alloc] initWithLabel:@"State"];
    [self.scrollView addSubview:self.stateField];
    [self.stateField belowView:self.cityField withMargin:FormFieldMargin];
    
    UIView* containerView = [self maskViews:[NSArray arrayWithObjects:self.firstNameField, self.lastNameField, self.cityField, self.stateField, nil]];
    [self.scrollView addSubview:containerView];

    return self;
}

-(void)setUser:(User *)user {
    _user = user;
    [self.userImgView setImageWithPath:user.imgPath];
    self.firstNameField.text = user.info.firstName;
    self.lastNameField.text = user.info.lastName;
    self.cityField.text = user.info.city;
    self.stateField.text = user.info.state;
}

@end
