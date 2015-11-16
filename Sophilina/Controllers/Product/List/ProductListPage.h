#import "Page.h"

@interface ProductListPage : TableViewPage

@property(strong,nonatomic)ProductDetailsList* ProductDetailsList;

-(void)appendProductDetailsList:(ProductDetailsList*) ProductDetailsList toIndex:(int)index;

@end
