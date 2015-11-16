#import "SendMessagePage.h"

@interface CreateProductPage : FormPage
{
@protected
    UIView* containerView;
}

@property(strong,nonatomic)FullWidthField* textFieldSubject;
@property(strong,nonatomic)NSUITextView* textFieldContent;
@property(strong,nonatomic)UIImageView* cameraView;
@property(strong,nonatomic)UILabel* labelAttachment;
@property(strong,nonatomic)NSMutableArray* images;
@property(strong, nonatomic)LabelWithCaption* labelLocation;
@property(strong, nonatomic)NSString* city;
@property(strong, nonatomic)NSString* state;

-(void)addImage:(UIImage*)img;

@end
