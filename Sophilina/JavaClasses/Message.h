#import "Data.h"

@interface Message : Data

@property(strong, nonatomic) NSString* threadId;
@property(strong, nonatomic) NSString* ownerId;
@property(strong, nonatomic) NSString* senderId;
@property(strong, nonatomic) NSString* recipientId;
@property(strong, nonatomic) NSString* subject;
@property(strong, nonatomic) NSString* content;
@property(strong, nonatomic) NSString* caseId;
@property(strong, nonatomic) NSString* orderId;
@property(strong, nonatomic) NSNumber* read;
@property(strong, nonatomic) NSMutableArray* attachments;
@property(strong, nonatomic) NSString* id;
@property(strong, nonatomic) NSNumber* version;
@property(strong, nonatomic) NSNumber* created;
@property(strong, nonatomic) NSNumber* updated;

@end
