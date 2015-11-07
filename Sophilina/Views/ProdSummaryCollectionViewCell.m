//  Next Shopper
//
//  Created by Kevin Zhang on 10/12/14.
//  Copyright (c) 2014 Gaoshin. All rights reserved.
//

#import "ProdSummaryCollectionViewCell.h"

@interface ProdSummaryCollectionViewCell()

@property(strong, nonatomic) ProductSummaryView* prodSummaryView;

@end

@implementation ProdSummaryCollectionViewCell

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    self.prodSummaryView = [[ProductSummaryView alloc] init];
    self.contentView.clipsToBounds = YES;
    [self.contentView addSubview:self.prodSummaryView];
    return self;
}

-(void)setProductDetails:(ProductDetails *)prod {
    [self.prodSummaryView setProductDetails:prod];
}

@end
