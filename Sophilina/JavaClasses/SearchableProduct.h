#import "Data.h"

@interface SearchableProduct : Data

@property(strong, nonatomic) NSString* id;
@property(strong, nonatomic) NSString* storeId;
@property(strong, nonatomic) NSMutableArray* tags;
@property(strong, nonatomic) NSString* name;
@property(strong, nonatomic) NSString* status;
@property(strong, nonatomic) NSString* _description;
@property(strong, nonatomic) NSString* manufacture;
@property(strong, nonatomic) NSMutableArray* imgUrl;
@property(strong, nonatomic) NSString* model;
@property(strong, nonatomic) NSNumber* likes;
@property(strong, nonatomic) NSNumber* reviews;
@property(strong, nonatomic) NSNumber* rating;
@property(strong, nonatomic) NSNumber* price;
@property(strong, nonatomic) NSNumber* listPrice;
@property(strong, nonatomic) NSString* country;
@property(strong, nonatomic) NSNumber* created;

@end
