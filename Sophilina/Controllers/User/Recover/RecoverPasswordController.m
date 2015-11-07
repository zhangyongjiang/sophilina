//
//  SignupViewController.m
//
//
//  Created by Kevin Zhang on 11/17/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "RecoverPasswordViewController.h"
#import "RecoverPasswordPage.h"

@interface RecoverPasswordViewController ()

@property(strong,nonatomic)RecoverPasswordPage* page;

@end

@implementation RecoverPasswordViewController

-(void)createPage {
    CGFloat y = 0;
    self.transparentNavbar = YES;
    if (self.page) {
        [self.page removeFromSuperview];
        UIView* navBar = self.navigationController.navigationBar;
        y = navBar.bottom;
    }
//    self.title = @"Recover Password";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addNavRightButton:@"Send" target:self action:@selector(recoverPassword)];
    self.page = [[RecoverPasswordPage alloc] initWithFrame:self.view.bounds];
    self.page.y = y;
    [self.view addSubview:self.page];
}

-(void)recoverPassword {
    LoginRequest *req = [[LoginRequest alloc] init];
    req.email = self.page.emailField.text;
    if (req.email.length == 0) {
        [self alertWithTitle:@"Oops" andMsg:@"Email is required to recover your password." handler:nil];
        return;
    }
    [ReuselocalApi UserAPI_ResetPassword:req onSuccess:^(GenericResponse *resp) {
        [self alertWithTitle:@"Information" andMsg:@"Please check your email for the temp password" handler:^(UIAlertAction *action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } onError:^(APIError *err) {
        if (err.statusCode == 560) {
            [self alertWithTitle:@"Oops" andMsg:@"Email doesn't exist." handler:^(UIAlertAction *action) {
            }];
            err.processed = YES;
        }
    }];
}
@end
