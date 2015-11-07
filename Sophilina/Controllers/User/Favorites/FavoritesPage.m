//
//  FavoritesPage.m
//
//
//  Created by Kevin Zhang on 11/16/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "FavoritesPage.h"

@interface FavoritesPage() <UIGestureRecognizerDelegate>

@property(strong,nonatomic)EmptyPage* emptyPage;

@end

@implementation FavoritesPage

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self createEmptyView];
    return self;
}

-(void)createEmptyView {
    self.emptyPage = [[EmptyPage alloc] initWithFrame:self.frame];
    self.emptyPage.imgView.image = [UIImage imageNamed:@"like"];
    self.emptyPage.label.text = @"You don't have favorite.";
    self.emptyPage.hidden = YES;
}

@end
