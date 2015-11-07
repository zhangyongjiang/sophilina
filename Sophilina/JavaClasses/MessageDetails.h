#import "Data.h"
#import "Message.h"
#import "User.h"

@interface MessageDetails : Data

@property(strong, nonatomic) Message* message;
@property(strong, nonatomic) User* userSenderInfo;
@property(strong, nonatomic) User* userReceiverInfo;

@end
