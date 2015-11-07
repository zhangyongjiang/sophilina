#import "Data.h"

@interface BusinessExceptionResponse : Data

@property(strong, nonatomic) NSString* errorCode;
@property(strong, nonatomic) NSString* stack;
@property(strong, nonatomic) NSString* errorMsg;

@end
