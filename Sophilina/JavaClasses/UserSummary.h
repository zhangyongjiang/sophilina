#import "Data.h"

@interface UserSummary : Data

@property(strong, nonatomic) NSNumber* productReviews;
@property(strong, nonatomic) NSNumber* storeReviews;
@property(strong, nonatomic) NSNumber* likes;
@property(strong, nonatomic) NSNumber* followers;
@property(strong, nonatomic) NSNumber* followings;
@property(strong, nonatomic) NSNumber* storeFollowings;
@property(strong, nonatomic) NSString* id;
@property(strong, nonatomic) NSNumber* version;
@property(strong, nonatomic) NSNumber* created;
@property(strong, nonatomic) NSNumber* updated;

@end
