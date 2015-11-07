#import "Data.h"
#import "Message.h"

@interface InOutMessage : Data

@property(strong, nonatomic) Message* in;
@property(strong, nonatomic) Message* out;

@end
