//
//  MessageItemView.m
//
//
//  Created by Kevin Zhang on 1/4/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "MessageItemView.h"
#import "ImageViewController.h"
#import "SysUser.h"
#import "SysUser+Util.h"

@interface MessageItemView()

@property(strong,nonatomic)MediumUserImageView* userImgView;
@property(strong,nonatomic)UILabel* labelComment;
@property(strong,nonatomic)UILabel* userName;
@property(strong,nonatomic)FitLabel* labelDate;

@end

@implementation MessageItemView

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = FormBorderColor.CGColor;
    self.layer.borderWidth = 0.5;
    
    self.userImgView = [[MediumUserImageView alloc] init];
    self.userImgView.x = PagePadding;
    self.userImgView.y = PagePadding;
    [self addSubview:self.userImgView];
    
    self.userName = [[FitLabel alloc] initWithFrame:CGRectMake(self.userImgView.right+PagePadding, PagePadding, 0, 0)];
    [self.userName styleTableViewRowLabel];
    [self addSubview:self.userName];
    
    self.labelDate = [[FitLabel alloc] init];
    [self.labelDate styleTime];
    [self addSubview:self.labelDate];
    
    self.labelComment = [[UILabel alloc] initWithFrame:CGRectMake(self.userName.x, self.userName.bottom + PagePadding*2, MessageItemCommentWidth, 0)];
    [self.labelComment styleContent];
    self.labelComment.numberOfLines = 0;
    [self addSubview:self.labelComment];
    
    return self;
}

-(void)setMessageDetails:(MessageDetails*)data {
    _messageDetails = data;
    
    self.labelDate.text = [[NSDate fromMilliseconds:data.message.created] timeAgo];
    [self.labelDate alignParentRightWithMarghin:PagePadding];
    self.labelDate.ycenter = self.userName.ycenter;

    User* me = [NSUserDefaults savedUser];
    if([data.message.senderId isEqualToString:me.id]) {
        [self.userImgView setImageWithPath:me.imgPath];
        self.userName.text = [NSString stringWithFormat:@"%@ %@", me.info.firstName, me.info.lastName];
    }
    else if ([SysUser isSysUser:data.message.senderId]) {
        self.userImgView.image = [UIImage imageNamed:@"menu-shop"];
        self.userName.text = @"NextShopper";
    }
    else if(data.userSenderInfo){
            [self.userImgView setImageWithPath:data.userSenderInfo.imgPath];
            self.userName.text = [NSString stringWithFormat:@"%@ %@", data.userReceiverInfo.info.firstName, data.userReceiverInfo.info.lastName];
    }
    self.labelDate.ycenter = self.userName.ycenter;
    
    [self.labelComment setText:data.message.content withLineSpacing:4];
    CGSize size = [self.labelComment sizeThatFits:CGSizeMake(self.labelComment.width-PagePadding, CGFLOAT_MAX)];
    self.labelComment.height = size.height;
    
    int row = 0;
    int col = 0;
    CGFloat startY = self.labelComment.bottom + PagePadding;
    if (startY < self.userImgView.bottom + PagePadding) {
        startY = self.userImgView.bottom + PagePadding;
    }
    CGFloat width = ([UIView screenWidth] - 4 * PagePadding) / 3.f;
    UIImageView* last = nil;
    for (NSString* attached in data.message.attachments) {
        if (!attached || [attached isKindOfClass:[NSNull class]]) {
            continue;
        }
        CGFloat x = (width  + PagePadding) * col + PagePadding;
        CGFloat y = startY + row * (width + PagePadding);
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
        self.height = self.labelComment.bottom + PagePadding;
    if (self.height < self.userImgView.bottom + PagePadding) {
        self.height = self.userImgView.bottom + PagePadding;
    }
}

-(void)imgClicked:(UIGestureRecognizer *)gestureRecognizer {
    UIImageView* view = gestureRecognizer.view;
    ImageViewController* controller = [[ImageViewController alloc] init];
    controller.image = view.image;
    [[NSNotificationCenter defaultCenter] presentControllerNotification:controller fromView:self];
}

@end
