#import "Data.h"
#import "UserBasicInfo.h"

@interface User : Data

@property(strong, nonatomic) UserBasicInfo* info;
@property(strong, nonatomic) NSString* imgPath;
@property(strong, nonatomic) NSString* type;
@property(strong, nonatomic) NSString* status;
@property(strong, nonatomic) NSString* id;
@property(strong, nonatomic) NSNumber* version;
@property(strong, nonatomic) NSNumber* created;
@property(strong, nonatomic) NSNumber* updated;

@end
