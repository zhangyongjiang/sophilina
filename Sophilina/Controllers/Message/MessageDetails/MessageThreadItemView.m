//
//  ProductView.m
//
//
//  Created by Kevin Zhang on 1/3/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "MessageThreadItemView.h"
#import "ImageViewController.h"

#define ImgWidth    45

@interface MessageThreadItemView()

@property(strong, nonatomic)UIImageView* iconImgView;
@property(strong, nonatomic)UILabel* titleLabel;
@property(strong, nonatomic)FitLabel* dateLabel;
@property(strong, nonatomic)UILabel* summaryLabel;

@end

@implementation MessageThreadItemView

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor whiteColor];
    self.iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(PagePadding, PagePadding, ImgWidth, ImgWidth)];
    [self addSubview:self.iconImgView];
    self.iconImgView.layer.cornerRadius = ImgWidth/2.;
    self.iconImgView.layer.masksToBounds = YES;
    
    self.dateLabel = [[FitLabel alloc] init];
    self.dateLabel.x = self.iconImgView.right + PagePadding;
    [self.dateLabel h4];
    self.dateLabel.y = PagePadding;
    [self addSubview:self.dateLabel];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.iconImgView.right + PagePadding, PagePadding, [UIView screenWidth]-self.iconImgView.right-PagePadding, 0)];
    self.titleLabel.text = @"some title text";
    [self.titleLabel h4];
    [self.titleLabel rightOfView:self.iconImgView withMargin:PagePadding];
    self.titleLabel.numberOfLines = 0;
    [self addSubview:self.titleLabel];
    
    self.summaryLabel = [[UILabel alloc] initWithFrame:CGRectMake(ImgWidth+PagePadding*2, self.titleLabel.height+PagePadding*2, self.width - ImgWidth - PagePadding*3, 50)];
    self.summaryLabel.text = @"some summary text";
    self.summaryLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.summaryLabel h4];
    self.summaryLabel.numberOfLines = 0;
    [self.summaryLabel rightOfView:self.iconImgView withMargin:PagePadding];
    [self addSubview:self.summaryLabel];

    return self;
}

-(void)setMessageDetails:(MessageDetails*)data {
    _messageDetails = data;
    
    if (data.message.subject) {
        self.titleLabel.text = data.message.subject;
    }
    else {
        self.titleLabel.text = @"(##no subject##)";
    }
    [self.titleLabel fitHeight];

    self.dateLabel.text = [NSDate toYmdhm:data.message.created];
    [self.dateLabel belowView:self.titleLabel withMargin:PagePadding];
    
    [self.summaryLabel belowView:self.dateLabel withMargin:5];
    
    NSMutableString* body = [[NSMutableString alloc] initWithString:@""];
    
    
    User* me = [NSUserDefaults savedUser];
    if([data.message.senderId isEqualToString:me.id]) {
        [self.iconImgView setImageWithPath:me.imgPath];
    }
    else if(data.userSenderInfo){
        [self.iconImgView setImageWithPath:data.userSenderInfo.imgPath];
    }
    if ([data.message.senderId isEqual:data.message.ownerId]) {
        if (data.userReceiverInfo) {
            if ([SysUser isSysUser:data.message.recipientId]) {
                [body appendFormat:@"##To##: NextShopper\n"];
            }
            else {
                [body appendFormat:@"##To##: %@ %@\n", data.userReceiverInfo.info.firstName, data.userReceiverInfo.info.lastName];
            }
        }
    }
    else {
        if (data.userSenderInfo) {
            if ([SysUser isSysUser:data.message.recipientId]) {
                [body appendFormat:@"##From##: NextShopper\n"];
            }
            else {
                [body appendFormat:@"##From##: %@ %@\n", data.userSenderInfo.info.firstName, data.userSenderInfo.info.lastName];
            }
        }
    }
    if(data.message.content) {
        [body appendString:data.message.content];
    }
    self.summaryLabel.text = body;
    CGSize size = [self.summaryLabel sizeThatFits:CGSizeMake(self.summaryLabel.width-PagePadding, CGFLOAT_MAX)];
    self.summaryLabel.height = size.height;
    
    int row = 0;
    int col = 0;
    CGFloat width = ([UIView screenWidth] - 4 * PagePadding) / 3.f;
    UIImageView* last = nil;
    for (NSString* attached in data.message.attachments) {
        if (!attached || [attached isKindOfClass:[NSNull class]]) {
            continue;
        }
        CGFloat x = (width  + PagePadding) * col + PagePadding;
        CGFloat y = self.summaryLabel.bottom + PagePadding + row * (width + PagePadding);
        col++;
        if(col==3) {
            row++;
            col = 0;
        }
        UIImageView* imgView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        [self addSubview:imgView];
        [imgView setImageWithPath:attached placeholderImage:[UIImage animatedImageNamed:@"loading-" duration:1.0]];
        last = imgView;
        [imgView addTarget:self action:@selector(imgClicked:)];
    }
    
    if(last)
        self.height = last.bottom + PagePadding;
    else
        self.height = self.summaryLabel.bottom + PagePadding;
}

-(void)imgClicked:(UIGestureRecognizer *)gestureRecognizer {
    UIImageView* view = gestureRecognizer.view;
    ImageViewController* controller = [[ImageViewController alloc] init];
    controller.image = view.image;
    [[NSNotificationCenter defaultCenter] presentControllerNotification:controller fromView:self];
}

@end
