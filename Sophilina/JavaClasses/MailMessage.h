#import "Data.h"

@interface MailMessage : Data

@property(strong, nonatomic) NSMutableArray* to;
@property(strong, nonatomic) NSString* from;
@property(strong, nonatomic) NSString* userName;
@property(strong, nonatomic) NSString* subject;
@property(strong, nonatomic) NSString* content;
@property(strong, nonatomic) NSNumber* isHtml;

@end
