//
//  ProductView.m
//
//
//  Created by Kevin Zhang on 1/3/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "ProductListItemView.h"
#import "ProductDetailsViewController.h"
#import "NewMessageViewController.h"
#import "ProductDetailsViewController.h"

@interface ProductListItemView()

@property(strong,nonatomic)FitLabel* labelDate;
@property(strong,nonatomic)UIImageView* prodImgView;
@property(strong,nonatomic)UILabel* labelProdName;
@property(strong,nonatomic)UILabel* labelStatus;
@end


@implementation ProductListItemView

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    self.labelDate = [[FitLabel alloc] initWithFrame:CGRectMake(PagePadding, PagePadding, 0, 0)];
    [self.labelDate styleTime];
    [self addSubview:self.labelDate];
    
    CGFloat imgWidth = 60*[UIView scale];
    self.prodImgView = [[UIImageView alloc] initWithFrame:CGRectMake(PagePadding, 0, imgWidth, imgWidth)];
    [self addSubview:self.prodImgView];
    [self.prodImgView addTarget:self action:@selector(seeProduct)];
    
    self.labelProdName = [[UILabel alloc] initWithFrame:CGRectMake(imgWidth+2*PagePadding, 0, 0, 30)];
    [self.labelProdName styleTableViewRowLabel];
    self.labelProdName.numberOfLines = 2;
    [self addSubview:self.labelProdName];
    [self.labelProdName extendToParentRightWithMargin:PagePadding];
    
    self.labelStatus = [[FitLabel alloc] init];
    [self.labelStatus styleTableViewRowTag];
    [self addSubview:self.labelStatus];
    
    return self;
}

-(void)seeProduct {
    if (self.ProductDetails.product == nil) {
        [[AppDelegate getInstance] alertWithTitle:@"Oops" andMsg:@"Product has been removed" handler:^(UIAlertAction *action) {
        }];
//        [[iToast makeText:@"Product has been removed"] show];
        return;
    }
    if (![self.ProductDetails.product.status isEqualToString:@"Active"]) {
        [[AppDelegate getInstance] alertWithTitle:@"Oops" andMsg:@"Product is not in the active state" handler:^(UIAlertAction *action) {
        }];
//        [[iToast makeText:@"Product is not in the active state"] show];
        return;
    }
    ProductDetailsViewController* controller = [[ProductDetailsViewController alloc] init];
    controller.productId = self.ProductDetails.product.id;
    [[NSNotificationCenter defaultCenter] postControllerNotification:controller fromView:self];
}

-(UIButton*)createButton:(NSString*)title {
    UIButton* btn = [[UIButton alloc] init];
    btn.height = 40;
    [btn styleTableViewRowContent];
//    btn.backgroundColor = FormBorderColor;
    btn.width = [UIView screenWidth]/2 - 0.25;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
    [self addSubview:btn];
    return btn;
}

-(void)gotoOrderDetailsViewController {
    ProductDetailsViewController* controller = [[ProductDetailsViewController alloc] init];
    controller.productId = self.ProductDetails.product.id;
    [[NSNotificationCenter defaultCenter] postControllerNotification:controller fromView:self];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    [self.prodImgView belowView:self.labelDate withMargin:PagePadding];
    [self.labelProdName belowView:self.labelDate withMargin:PagePadding];
    [self.labelStatus alignParentRightWithMarghin:PagePadding];
    [self.labelStatus alignTopWithView:self.labelDate];
}

-(void)setProductDetails:(ProductDetails *)ProductDetails {
    _ProductDetails = ProductDetails;
    [self.prodImgView setImageWithPathArray:ProductDetails.product.imgs];
    self.labelProdName.text = ProductDetails.product.info.name;
    self.labelDate.text = [NSDate toYmdhm:ProductDetails.product.created];
}
@end
