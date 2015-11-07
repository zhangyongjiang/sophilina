#import "Data.h"

@interface UserBasicInfo : Data

@property(strong, nonatomic) NSString* firstName;
@property(strong, nonatomic) NSString* lastName;
@property(strong, nonatomic) NSString* country;
@property(strong, nonatomic) NSString* zipcode;
@property(strong, nonatomic) NSString* gender;
@property(strong, nonatomic) NSNumber* birthday;
@property(strong, nonatomic) NSString* about;
@property(strong, nonatomic) NSString* phoneList;

@end
