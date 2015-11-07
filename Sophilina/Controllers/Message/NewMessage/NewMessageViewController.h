#import "BaseViewController.h"

enum MessageType { User2Store, User2System, Store2User, Store2System, Reply };
typedef enum MessageType MessageType;

@interface NewMessageViewController : BaseViewController

@property(assign,nonatomic)MessageType messageType;
@property(strong,nonatomic)NSString* orderId;
@property(strong,nonatomic)NSString* storeId;
@property(strong,nonatomic)NSString* msgId;
@property(strong,nonatomic)NSString* subject;
@property(strong,nonatomic)NSString* body;
@end
