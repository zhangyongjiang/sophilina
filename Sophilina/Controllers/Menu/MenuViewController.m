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

@interface MenuViewController() <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(strong,nonatomic)MenuPage* page;

@end

@implementation MenuViewController

-(void)createPage {
    CGFloat y = 0;
    if (self.page) {
        [self.page removeFromSuperview];
        UIView* navBar = self.navigationController.navigationBar;
        y = navBar.bottom;
    }
    self.page = [[MenuPage alloc] initWithFrame:self.view.frame];
    self.page.y = y;
    [self.view addSubview:self.page];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(postProduct:) name:@"Post" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout:) name:@"Logout" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login:) name:@"Login" object:nil];
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


@end
