#import "Data.h"

@interface ProductLocation : Data

@property(strong, nonatomic) NSNumber* latitude;
@property(strong, nonatomic) NSNumber* longitude;
@property(strong, nonatomic) NSString* address1;
@property(strong, nonatomic) NSString* address2;
@property(strong, nonatomic) NSString* city;
@property(strong, nonatomic) NSString* state;
@property(strong, nonatomic) NSString* country;
@property(strong, nonatomic) NSString* zipcode;

@end
