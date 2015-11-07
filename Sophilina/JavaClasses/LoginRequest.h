#import "Data.h"

@interface LoginRequest : Data

@property(strong, nonatomic) NSString* email;
@property(strong, nonatomic) NSString* password;

@end
