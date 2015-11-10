//
//  WelcomePage.h
//
//
//  Created by Kevin Zhang on 11/16/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "Page.h"
#import "SocialButtons.h"

@interface WelcomePage2 : Page

@property(strong,nonatomic)LogoImageView* logoView;
@property(strong,nonatomic)NSButton* signinBtn;
@property(strong,nonatomic)NSButton* signupBtn;
@property(strong,nonatomic)UILabel* skipForNowLabel;

@end
