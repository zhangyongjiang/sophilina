//
//  MenuViewController.m
//
//
//  Created by Kevin Zhang on 11/16/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuPage.h"
#import "UIImage+ImageEffects.h"
#import "CreateProductViewController.h"
#import "UpdateProfileViewController.h"
#import "ChangePasswordViewController.h"

@interface MenuViewController() <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(strong,nonatomic)Page* page;

@end

@implementation MenuViewController

-(void)createPage {
    CGFloat y = 0;
    if (self.page) {
        [self.page removeFromSuperview];
        UIView* navBar = self.navigationController.navigationBar;
        y = navBar.bottom;
    }
    
    if ([NSUserDefaults savedUser]) {
        self.page = [[UserMenuPage alloc] initWithFrame:self.view.frame];
    }
    else {
        self.page = [[GuestMenuPage alloc] initWithFrame:self.view.frame];
    }
    self.page.y = y;
    [self.view addSubview:self.page];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(postProduct:) name:@"Give Free" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout:) name:@"Logout" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login:) name:@"Login" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(profile:) name:@"Profile" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changePassword:) name:@"Change Password" object:nil];
}

-(void)postProduct:(NSNotification *) notification  {
    CreateProductViewController* controller = [[CreateProductViewController alloc] init];
    [[AppDelegate getInstance] pushViewController:controller];
}

-(void)logout:(NSNotification *) notification  {
    [WebService UserAPI_Logout:^(GenericResponse *resp) {
        [[AppDelegate getInstance] startWelcomePage:NO];
    } onError:^(APIError *err) {
        
    }];
}

-(void)login:(NSNotification *) notification  {
    [[AppDelegate getInstance] startWelcomePage:YES];
}

-(void)changePassword:(NSNotification *) notification  {
    ChangePasswordViewController* controller = [[ChangePasswordViewController alloc] init];
    [[AppDelegate getInstance] pushViewController:controller];
}

-(void)profile:(NSNotification *) notification  {
    UpdateProfileViewController* controller = [[UpdateProfileViewController alloc] init];
    [[AppDelegate getInstance] pushViewController:controller];
}


@end
