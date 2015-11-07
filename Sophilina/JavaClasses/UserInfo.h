#import "Data.h"
#import "UserBasicInfo.h"
#import "UserSummary.h"

@interface UserInfo : Data

@property(strong, nonatomic) NSString* userId;
@property(strong, nonatomic) UserBasicInfo* basic;
@property(strong, nonatomic) UserSummary* summary;

@end
