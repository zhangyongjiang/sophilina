//
//  ProductListPage.m
//
//
//  Created by Kevin Zhang on 11/16/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "ProductListPage.h"
#import "ProductListItemTableViewCell.h"
#import "ProductDetailsViewController.h"
#import "ProductListEmptyView.h"

#define ProductListItemTableViewCellID @"ProductListItemTableViewCellID"

@interface ProductListPage()

@property(strong,nonatomic)OrderListEmptyView* emptyView;

@end

@implementation ProductListPage

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [_tableView registerClass:[ProductListItemTableViewCell class] forCellReuseIdentifier:ProductListItemTableViewCellID];
//    _tableView.allowsSelection = NO;
    
    self.emptyView = [[OrderListEmptyView alloc] initWithFrame:self.frame];
    self.emptyView.hidden = YES;
    _tableView.backgroundView = self.emptyView;
    
    return self;
}

-(void)setProductDetailsList:(ProductDetailsList*)ProductDetailsList {
    if (ProductDetailsList.items.count == 0) {
//        [self setEmptyPageText:@"You don't have any order."];
        self.emptyView.hidden = NO;
    }
    else {
        self.emptyView.hidden = YES;
        [self setEmptyPageText:nil];
    }
    _ProductDetailsList = ProductDetailsList;
    [_tableView reloadData];
}

-(void)appendProductDetailsList:(ProductDetailsList*) ProductDetailsList  toIndex:(int)index {
    [_ProductDetailsList.items removeObjectsInRange:NSMakeRange(index, _ProductDetailsList.items.count-index)];
    [_ProductDetailsList.items addObjectsFromArray:ProductDetailsList.items];
    [_tableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.ProductDetailsList.items.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [self checkNextPageForTableView:tableView indexPath:indexPath];
    ProductListItemTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ProductListItemTableViewCellID];
    ProductDetails* ProductDetails = [self.ProductDetailsList.items objectAtIndex:indexPath.section];
    [cell setProductDetails:ProductDetails];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ProductListItemViewHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductDetails* ProductDetails = [self.ProductDetailsList.items objectAtIndex:indexPath.section];
    ProductDetailsViewController* controller = [[ProductDetailsViewController alloc] init];
    controller.productId = ProductDetails.product.id;
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationPushController object:tableView userInfo:[NSDictionary  dictionaryWithObjectsAndKeys:controller, @"controller",nil]];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIView screenWidth], 20)];
    return view;
}
@end
