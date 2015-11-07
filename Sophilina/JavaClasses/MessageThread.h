#import "Data.h"
#import "MessageDetails.h"

@interface MessageThread : Data

@property(strong, nonatomic) NSString* msgId;
@property(strong, nonatomic) NSMutableArray* items;

@end
