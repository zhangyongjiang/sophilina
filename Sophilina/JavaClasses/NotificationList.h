#import "Data.h"
#import "Notification.h"

@interface NotificationList : Data

@property(strong, nonatomic) NSNumber* total;
@property(strong, nonatomic) NSNumber* totalUnread;
@property(strong, nonatomic) NSMutableArray* items;

@end
