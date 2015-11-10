//
//  WelcomeViewController.m
//
//
//  Created by Kevin Zhang on 11/16/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "WelcomeViewController.h"
#import "WelcomePage2.h"
#import "SigninViewController.h"
#import "SignupViewController.h"
#import "HomeViewController.h"

@interface WelcomeViewController ()

@property(strong, nonatomic)WelcomePage2* page;

@end

@implementation WelcomeViewController

-(id)init {
    self = [super init];
    self.showSkip = YES;
    return self;
}

-(void)createPage {
    self.transparentNavbar = YES;
//    self.title = @"Next Shopper";
    CGFloat y = 0;
    if (self.page) {
        [self.page removeFromSuperview];
        UIView* navBar = self.navigationController.navigationBar;
        y = navBar.bottom;
    }
    self.page = [[WelcomePage2 alloc] initWithFrame:self.view.bounds];
    self.page.y = y;
    [self.view addSubview:self.page];
    
    [self.page.signinBtn addTarget:self action:@selector(signinBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.page.signupBtn addTarget:self action:@selector(signupBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.page.skipForNowLabel addTarget:self action:@selector(skip)];
    
    if(!self.showSkip) {
        self.page.skipForNowLabel.hidden = YES;
    }
}

- (void)signinBtnClicked {
    [self.navigationController pushViewController:[[SigninViewController alloc] init] animated:YES];
}

- (void)signupBtnClicked {
    [self.navigationController pushViewController:[[SignupViewController alloc] init] animated:YES];
}

- (void)skip {
    [[AppDelegate getInstance] resumePage];
}

@end
