#import "Data.h"

@interface Address : Data

@property(strong, nonatomic) NSString* addr1;
@property(strong, nonatomic) NSString* addr2;
@property(strong, nonatomic) NSString* city;
@property(strong, nonatomic) NSString* state;
@property(strong, nonatomic) NSString* zipcode;
@property(strong, nonatomic) NSString* country;

@end
