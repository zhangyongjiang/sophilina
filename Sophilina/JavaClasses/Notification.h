#import "Data.h"

@interface Notification : Data

@property(strong, nonatomic) NSString* userId;
@property(strong, nonatomic) NSString* type;
@property(strong, nonatomic) NSString* msg;
@property(strong, nonatomic) NSString* imgPath;
@property(strong, nonatomic) NSString* data;
@property(strong, nonatomic) NSNumber* viewed;
@property(strong, nonatomic) NSString* id;
@property(strong, nonatomic) NSNumber* version;
@property(strong, nonatomic) NSNumber* created;
@property(strong, nonatomic) NSNumber* updated;

@end
