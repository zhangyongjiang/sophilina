#import "Data.h"

@interface NotificationSettings : Data

@property(strong, nonatomic) NSNumber* enabled;
@property(strong, nonatomic) NSString* id;
@property(strong, nonatomic) NSNumber* version;
@property(strong, nonatomic) NSNumber* created;
@property(strong, nonatomic) NSNumber* updated;

@end
