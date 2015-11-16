#import "Data.h"

@interface UserBasicInfo : Data

@property(strong, nonatomic) NSString* firstName;
@property(strong, nonatomic) NSString* lastName;
@property(strong, nonatomic) NSString* country;
@property(strong, nonatomic) NSString* zipcode;
@property(strong, nonatomic) NSString* city;
@property(strong, nonatomic) NSString* state;

@end
