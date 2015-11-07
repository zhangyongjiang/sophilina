//  Created by Kevin Zhang on 10/12/14.
//  Copyright (c) 2014 Gaoshin. All rights reserved.
//


#define ProdSummaryWidth        HalfWidthExcludePadding3
#define ProdSummaryBottomHeight 72
#define ProdSummaryHeight       (ProdSummaryWidth + ProdSummaryBottomHeight)

@interface ProductSummaryView : UIView

@property(strong,nonatomic)ProductDetails* productDetails;

@end
