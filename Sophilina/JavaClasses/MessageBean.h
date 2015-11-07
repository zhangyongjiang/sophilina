#import "Data.h"

@interface MessageBean : Data

@property(strong, nonatomic) NSString* threadId;
@property(strong, nonatomic) NSString* recipientId;
@property(strong, nonatomic) NSString* orderId;
@property(strong, nonatomic) NSString* subject;
@property(strong, nonatomic) NSString* content;
@property(strong, nonatomic) NSMutableArray* attachments;

@end
