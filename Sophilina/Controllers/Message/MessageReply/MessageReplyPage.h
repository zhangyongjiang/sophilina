#import "Page.h"

@interface MessageReplyPage : FormPage

@property(strong, nonatomic)MessageDetails* originalMessage;

@property(strong,nonatomic)FormTextField* textFieldSubject;
@property(strong,nonatomic)NSUITextView* textFieldContent;
@property(strong,nonatomic)UIImageView* cameraView;
@property(strong,nonatomic)UILabel* labelAttachment;
@property(strong,nonatomic)NSMutableArray* images;

-(void)addImage:(UIImage*)img;

@end
