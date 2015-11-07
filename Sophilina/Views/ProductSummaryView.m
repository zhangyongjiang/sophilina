//
//  PinSummaryView.m
//  Next Shopper
//
//  Created by Kevin Zhang on 10/12/14.
//  Copyright (c) 2014 Gaoshin. All rights reserved.
//

#import "ProductSummaryView.h"

@interface ProductSummaryView()

@property(strong, nonatomic) UIImageView* prodImgView;
@property(strong, nonatomic) FitLabel* listPriceLabel;
@property(strong, nonatomic) FitLabel* salePriceLabel;
@property(strong, nonatomic) FitLabel* expireLabel;
@property(strong, nonatomic) FitLabel* ordersLabel;
@property(strong, nonatomic) UILabel* labelName;

//@property(strong, nonatomic) ProductLikesView* likeView;

@end

@implementation ProductSummaryView

-(id)init
{
    self = [super init];
    if(self) {
        CGFloat labelHeight = 28;
        self.backgroundColor = [UIColor whiteColor];
        self.frame = CGRectMake(0, 0, ProdSummaryWidth, ProdSummaryHeight);
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 4;
        self.layer.borderColor = FormBorderColor.CGColor;
        self.layer.borderWidth = 0.5;
        
        CGRect imgFrame = CGRectMake(0, 0, ProdSummaryWidth, ProdSummaryWidth);
        self.prodImgView = [[UIImageView alloc] initWithFrame:imgFrame];
        self.prodImgView.contentMode = UIViewContentModeScaleAspectFill;
        self.prodImgView.clipsToBounds = YES;
        [self addSubview:self.prodImgView];
        
        CGRect bottom = CGRectMake(0, ProdSummaryWidth, ProdSummaryWidth, ProdSummaryBottomHeight);
        UIView* bottomView = [[UIView alloc] initWithFrame:bottom];
        [self addSubview:bottomView];
        
        CGFloat xpadding = 5;
        CGFloat ypadding = 5;
        self.labelName = [[UILabel alloc] initWithFrame:CGRectMake(xpadding, ypadding, ProdSummaryWidth-xpadding*2, labelHeight)];
        self.labelName.numberOfLines = 2;
        self.labelName.textAlignment = NSTextAlignmentCenter;
        [self.labelName styleNameSmall];
        [bottomView addSubview:self.labelName];
        
//        self.likeView = [[ProductLikesView alloc] initWithFrame:CGRectMake(ProdSummaryWidth-ReviewViewWidth, 0, ReviewViewWidth, ReviewViewHeight)];
//        [bottomView addSubview:self.likeView];
//        [self.likeView vcenterInParent];
        
        self.salePriceLabel = [[FitLabel alloc] initWithFrame:CGRectMake(PagePadding, PagePadding+labelHeight+7, 0, 0)];
        [self.salePriceLabel styleSalePrice];
        [bottomView addSubview:self.salePriceLabel];
        
        self.listPriceLabel = [[FitLabel alloc] initWithFrame:CGRectMake(PagePadding, PagePadding+labelHeight+7, 0, 0)];
        [self.listPriceLabel styleOriginalPrice];
        [bottomView addSubview:self.listPriceLabel];

        self.expireLabel = [[FitLabel alloc] init];
        self.expireLabel.numberOfLines = 2;
        self.expireLabel.textAlignment = NSTextAlignmentCenter;
        [self.expireLabel styleNameSmall];
        [bottomView addSubview:self.expireLabel];
        
        self.ordersLabel = [[FitLabel alloc] init];
        self.ordersLabel.numberOfLines = 2;
        self.ordersLabel.textAlignment = NSTextAlignmentCenter;
        [self.ordersLabel styleNameSmall];
        [bottomView addSubview:self.ordersLabel];

    }
    return self;
}

-(void)setProductDetails:(ProductDetails *)pd
{
    _productDetails = pd;
}

@end
