#import "Data.h"

@interface FlagRequest : Data

@property(strong, nonatomic) NSNumber* created;
@property(strong, nonatomic) NSString* productId;
@property(strong, nonatomic) NSString* userId;
@property(strong, nonatomic) NSString* reason;

@end
