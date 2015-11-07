#import "Data.h"

@interface Memo : Data

@property(strong, nonatomic) NSString* creatorId;
@property(strong, nonatomic) NSNumber* time;
@property(strong, nonatomic) NSString* content;

@end
