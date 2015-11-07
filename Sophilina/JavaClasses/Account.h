#import "Data.h"

@interface Account : Data

@property(strong, nonatomic) NSString* userId;
@property(strong, nonatomic) NSString* extId;
@property(strong, nonatomic) NSString* type;
@property(strong, nonatomic) NSString* info;
@property(strong, nonatomic) NSString* id;
@property(strong, nonatomic) NSNumber* version;
@property(strong, nonatomic) NSNumber* created;
@property(strong, nonatomic) NSNumber* updated;

@end
