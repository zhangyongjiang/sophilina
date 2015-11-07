#import "Data.h"
#import "MessageDetails.h"

@interface MessageDetailsList : Data

@property(strong, nonatomic) NSNumber* total;
@property(strong, nonatomic) NSNumber* totalUnread;
@property(strong, nonatomic) NSMutableArray* items;

@end
