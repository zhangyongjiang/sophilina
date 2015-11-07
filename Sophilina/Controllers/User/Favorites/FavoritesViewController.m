//
//  WelcomeViewController.m
//
//
//  Created by Kevin Zhang on 11/16/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "FavoritesViewController.h"
#import "FavoritesPage.h"

@interface FavoritesViewController () <UIViewEventDelegate>

@property(strong, nonatomic)FavoritesPage* page;
@property(assign, nonatomic)int currentPage;

@end

@implementation FavoritesViewController

-(void)createPage {
    CGFloat y = 0;
    if (self.page) {
        [self.page removeFromSuperview];
        UIView* navBar = self.navigationController.navigationBar;
        y = navBar.bottom;
    }
    
    self.page = [[FavoritesPage alloc] initWithFrame:self.view.bounds];
    self.page.y = y;
    [self.view addSubview:self.page];
    self.title = @"Favorites";
    
    [self.page setEventDelegate:self];

    [self refreshPage];
}

-(void)refreshPage {
    self.currentPage = 0;
}

-(void)handleEvent:(NSString *)name fromSource:(NSObject *)source data:(NSObject *)data {
    if ([name isEqualToString:EventCollectionViewLongPress]) {
    }
}

-(void)nextPage {
}
@end
