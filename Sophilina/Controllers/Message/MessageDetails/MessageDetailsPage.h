#import "Page.h"

@interface MessageDetailsPage : Page

@property(strong,nonatomic)MessageThread* messageThread;
@property(strong,nonatomic)NSString* msgId;

@property(strong,nonatomic)NSButton* btnReply;

@end
