#import "Data.h"
#import "ProductDetails.h"
#import "User.h"

@interface ProductDetailsList : Data

@property(strong, nonatomic) NSNumber* total;
@property(strong, nonatomic) NSMutableArray* items;
@property(strong, nonatomic) User* owner;

@end
