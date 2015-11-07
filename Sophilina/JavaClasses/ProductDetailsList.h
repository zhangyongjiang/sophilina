#import "Data.h"
#import "ProductDetails.h"

@interface ProductDetailsList : Data

@property(strong, nonatomic) NSNumber* total;
@property(strong, nonatomic) NSMutableArray* items;

@end
