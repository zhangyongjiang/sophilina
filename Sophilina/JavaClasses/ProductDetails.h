#import "Data.h"
#import "Product.h"

@interface ProductDetails : Data

@property(strong, nonatomic) Product* product;
@property(strong, nonatomic) NSNumber* reviewed;
@property(strong, nonatomic) NSNumber* liked;

@end
