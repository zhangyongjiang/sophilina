//
//  ProductTableViewCell.m
//
//
//  Created by Kevin Zhang on 1/3/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "ProductListItemTableViewCell.h"

@interface ProductListItemTableViewCell()

@property(strong,nonatomic)ProductListItemView* view;

@end

@implementation ProductListItemTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.view = [[ProductListItemView alloc] initWithFrame:CGRectMake(0, 0, FullWidth, ProductListItemViewHeight)];
    self.accessoryType = UITableViewCellAccessoryNone;
    [self.contentView addSubview:self.view];
    self.clipsToBounds = YES;
    return self;
}

-(void)setProductDetails:(ProductDetails*)ProductDetails {
    [self.view setProductDetails:ProductDetails];
}
@end
