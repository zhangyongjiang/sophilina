//
//  ProductDetailsPage.m
//
//
//  Created by Kevin Zhang on 11/16/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "ProductDetailsPage.h"
#import "ProductDetails.h"
#import "ProductListViewController.h"

@interface ProductDetailsPage()

@property(strong,nonatomic)UIScrollView* scrollView;
@property(strong,nonatomic)UIRefreshControl* refreshControl;

@end

@implementation ProductDetailsPage

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    [self addSubview:self.scrollView];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
//    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [self.refreshControl addTarget:self action:@selector(reloadData) forControlEvents:UIControlEventValueChanged];
    [self.scrollView addSubview:self.refreshControl];
    
    self.galleryView = [[GalleryView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.width*0.75)];
    [self.scrollView addSubview:self.galleryView];
    
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(PagePadding, self.galleryView.bottom, FullWidthExcludePadding, 30)];
    [self.dateLabel styleTime];
    [self.scrollView addSubview:self.dateLabel];
    
    self.labelOwner = [[UILabel alloc] initWithFrame:CGRectMake(PagePadding, self.dateLabel.bottom, FullWidthExcludePadding, 30)];
    [self.scrollView addSubview:self.labelOwner];
    [self.labelOwner addTarget:self action:@selector(gotoUserPage)];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(PagePadding, self.labelOwner.bottom, FullWidthExcludePadding, 70)];
    [self.nameLabel styleContentBold];
    self.nameLabel.paddingTop = 10;
    [self.scrollView addSubview:self.nameLabel];
    
    self.labelDesc = [[UILabel alloc] initWithFrame:CGRectMake(PagePadding, self.nameLabel.bottom+PagePadding, FullWidthExcludePadding, 0)];
    [self.scrollView addSubview:self.labelDesc];
    
    return self;
}

-(void)gotoUserPage {
    ProductListViewController* controller = [[ProductListViewController alloc] init];
    controller.userId = self.prodDetails.product.userId;
    [[AppDelegate getInstance] pushViewController:controller];
}

-(void)setProdDetails:(ProductDetails *)prodDetails {
    _prodDetails = prodDetails;
    
    self.galleryView.imgs = prodDetails.product.imgs;
    self.dateLabel.text = [NSDate toYmdhm:prodDetails.product.created];
    self.labelOwner.text = [NSString stringWithFormat:@"Offered by %@", prodDetails.owner.info.firstName];
    [self.nameLabel setText:prodDetails.product.info.name withLineSpacing:4];

    self.labelDesc.text = prodDetails.product.info.details;
    [self.labelDesc fitHeight];
}

-(NSString *) stringByStrippingHTML:(NSString*)s {
    NSRange r;
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@" "];
    return s;
}

-(void)reloadData {
    [_refreshControl endRefreshing];
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationRefreshControl object:self];
}


@end
