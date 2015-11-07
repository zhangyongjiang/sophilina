#import "Data.h"

@interface Flag : Data

@property(strong, nonatomic) NSString* who;
@property(strong, nonatomic) NSString* targetId;
@property(strong, nonatomic) NSString* id;
@property(strong, nonatomic) NSNumber* version;
@property(strong, nonatomic) NSNumber* created;
@property(strong, nonatomic) NSNumber* updated;

@end
