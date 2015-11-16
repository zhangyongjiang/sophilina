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
@property(strong,nonatomic)FitLabel* labelOrderDetails;
@property(strong,nonatomic)UIImageView* prodImgView;
@property(strong,nonatomic)UILabel* labelProdName;
@property(strong,nonatomic)UILabel* labelStatus;
@property(strong,nonatomic)UILabel* labelOption;
@property(strong,nonatomic)UILabel* quantityLabel;
@property(strong,nonatomic)UILabel* priceLabel;
@property(strong,nonatomic)UIButton* btnRate;
@property(strong,nonatomic)UIButton* btnContact;

@property(strong,nonatomic)NSDictionary* statusDict;
@end


@implementation ProductListItemView

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
//    self.layer.borderColor = FormBorderColor.CGColor;
//    self.layer.borderWidth = 0.5;
    
    self.statusDict = [NSDictionary dictionaryWithObjectsAndKeys:	@"Processing",@"Submitted",
                       @"Cancelled", @"Cancelled",
                       @"In Transit", @"Shipped",
                       @"Delivered", @"Delivered",
                       @"Return Requested",@"ReturnRequested",
                       @"Refunded", @"Refunded",
                       @"Completed", @"Completed"
                       , nil];
    
    self.labelDate = [[FitLabel alloc] initWithFrame:CGRectMake(PagePadding, PagePadding, 0, 0)];
    [self.labelDate styleTime];
    [self addSubview:self.labelDate];
    
    self.labelOrderDetails = [[FitLabel alloc] initWithFrame:CGRectMake(0, PagePadding, 0, 0)];
//    self.labelOrderDetails.text = @"Order Details";
    self.labelOrderDetails.textColor = [UIColor colorWithRed:28.0/255.0 green:163.0/255.0 blue:229.0/255. alpha:1];
    [self.labelOrderDetails h4];
    [self addSubview:self.labelOrderDetails];
    [self.labelOrderDetails alignParentRightWithMarghin:PagePadding];
    [self.labelOrderDetails addTarget:self action:@selector(gotoOrderDetailsViewController)];
    
    CGFloat imgWidth = 60*[UIView scale];
    self.prodImgView = [[UIImageView alloc] initWithFrame:CGRectMake(PagePadding, 0, imgWidth, imgWidth)];
    [self addSubview:self.prodImgView];
    [self.prodImgView addTarget:self action:@selector(seeProduct)];
    
    self.labelProdName = [[UILabel alloc] initWithFrame:CGRectMake(imgWidth+2*PagePadding, 0, 0, 30)];
    [self.labelProdName styleTableViewRowLabel];
    self.labelProdName.numberOfLines = 2;
    [self addSubview:self.labelProdName];
    [self.labelProdName extendToParentRightWithMargin:PagePadding];
//    [self.labelProdName addTarget:self action:@selector(seeProduct)];
    
    self.labelOption = [[UILabel alloc] initWithFrame:CGRectMake(self.labelProdName.x, self.labelProdName.bottom+PagePadding, self.labelProdName.width, 0)];
    [self.labelOption styleTableViewRowTag];
    [self addSubview:self.labelOption];
    
    self.quantityLabel = [[FitLabel alloc] initWithFrame:CGRectMake(self.labelProdName.x, 0, 0, 0)];
    [self.quantityLabel styleTableViewRowTag];
    [self addSubview:self.quantityLabel];
    
    self.priceLabel = [[FitLabel alloc] initWithFrame:CGRectMake(self.labelProdName.x, 0, 0, 0)];
    [self.priceLabel styleTableViewRowTag];
    [self addSubview:self.priceLabel];

    self.labelStatus = [[FitLabel alloc] init];
    [self.labelStatus styleTableViewRowTag];
    [self addSubview:self.labelStatus];
    
    self.btnRate = [self createButton:@"Rate It!"];
    [self.btnRate addTarget:self action:@selector(addReview)];
    [self.btnRate alignParentBottomWithMarghin:0];
    
    self.btnContact = [self createButton:@"Contact Seller"];
    self.btnContact.x = [UIView screenWidth]/2 + 0.25;
    self.btnContact.layer.borderColor = [UIColor clearColor].CGColor;
    [self.btnContact addTarget:self action:@selector(contactSeller)];
    [self.btnContact alignParentBottomWithMarghin:0];

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
    [self.labelOption belowView:self.labelProdName withMargin:PagePadding/2];
    [self.labelStatus alignParentRightWithMarghin:PagePadding];
    [self.labelStatus alignTopWithView:self.labelDate];
    [self.quantityLabel belowView:self.labelOption withMargin:2];
    [self.priceLabel belowView:self.quantityLabel withMargin:2];
}

@end
