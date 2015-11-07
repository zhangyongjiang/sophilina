#import "Data.h"

@interface ChangePasswordRequest : Data

@property(strong, nonatomic) NSString* oldPassword;
@property(strong, nonatomic) NSString* password;

@end
