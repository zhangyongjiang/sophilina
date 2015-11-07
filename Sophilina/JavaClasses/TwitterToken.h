#import "Data.h"

@interface TwitterToken : Data

@property(strong, nonatomic) NSString* token;
@property(strong, nonatomic) NSString* tokenSecret;

@end
