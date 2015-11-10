//
//  SignupViewController.m
//
//
//  Created by Kevin Zhang on 11/17/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "CreateProductViewController.h"
#import "CreateProductPage.h"

@interface CreateProductViewController ()

@property(strong, nonatomic)CreateProductPage* page;

@end

@implementation CreateProductViewController

-(void)createPage {
    self.transparentNavbar = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.title = @"Sign In";
    CGFloat y = 0;
    if (self.page) {
        [self.page removeFromSuperview];
        UIView* navBar = self.navigationController.navigationBar;
        y = navBar.bottom;
    }
    
    self.page = [[CreateProductPage alloc] initWithFrame:self.view.bounds];
    self.page.y = y;
    
    //UIBarButtonItem* btn = [self addNavRightButton:@"Go" target:self action:@selector(signinBtnClicked)];
    [self.page.btnSignin addTarget:self action:@selector(signinBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.page.forgotPasswordLabel addTarget:self action:@selector(forgotPasswordClicked)];
    [self.page.emailField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.page.passwordField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    [self.view addSubview:self.page];
}


-(void)textFieldDidChange :(UITextField *)theTextField{
}

-(void)signinBtnClicked {
    [self.view endEditing:YES];

    [self.page.emailField resignFirstResponder];
    [self.page.passwordField resignFirstResponder];
    
    LoginRequest* req = [[LoginRequest alloc] init];
    req.email = self.page.emailField.text;
    req.password = self.page.passwordField.text;
    if (req.email.length == 0 || req.password.length == 0) {
        [self alertWithTitle:@"Oops" andMsg:@"Email and password are required." handler:nil];
        return;
    }
    [WebService UserAPI_Login:req onSuccess:^(User *resp) {
        [[AppDelegate getInstance] resumePage];
    } onError:^(APIError *err) {
        if ([err isInvalidInput]) {
            err.processed = YES;
            [self alertWithTitle:@"Oops" andMsg:@"Invalid inputs." handler:^(UIAlertAction *action) {
            }];
        }
        else if ([err isInvalidPassword]) {
            err.processed = YES;
            [self alertWithTitle:@"Oops" andMsg:@"Invalid Password." handler:^(UIAlertAction *action) {
            }];
        }
        else if ([err isNotFound]) {
            err.processed = YES;
            [self alertWithTitle:@"Oops" andMsg:@"Email account not found." handler:^(UIAlertAction *action) {
            }];
        }
    }];
}

- (void)forgotPasswordClicked {
}

@end
