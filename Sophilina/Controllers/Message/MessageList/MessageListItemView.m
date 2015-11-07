//
//  OrderItemView.m
//
//
//  Created by Kevin Zhang on 1/3/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "MessageListItemView.h"

@interface MessageListItemView()

@property(strong, nonatomic)UIImageView* iconImgView;
@property(strong, nonatomic)UILabel* titleLabel;
@property(strong, nonatomic)FitLabel* userLabel;
@property(strong, nonatomic)FitLabel* timeLabel;
@property(strong, nonatomic)UILabel* summaryLabel;
@property(strong, nonatomic)UIView* viewed;

@end

@implementation MessageListItemView

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
    
    self.iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(PagePadding, PagePadding, 45, 45)];
    self.iconImgView.image = [UIImage imageNamed:@"socialEmail"];
    self.iconImgView.layer.cornerRadius = self.iconImgView.width / 2.;
    self.iconImgView.layer.masksToBounds = YES;
    [self addSubview:self.iconImgView];
    
    self.userLabel = [[FitLabel alloc] initWithFrame:CGRectMake(self.iconImgView.right+PagePadding, self.iconImgView.y, 0, 0)];
    [self.userLabel styleTableViewRowLabel];
    [self addSubview:self.userLabel];
    
    self.viewed = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"red-dot.png"]];
    [self addSubview:self.viewed];
    
    self.titleLabel = [[FitLabel alloc] initWithScaledFrame:CGRectMake(self.iconImgView.right+PagePadding, 0, 0,0)];
    self.titleLabel.x = self.iconImgView.right+PagePadding;
    self.titleLabel.text = @"some title text";
    [self.titleLabel styleTableViewRowContent];
    [self addSubview:self.titleLabel];
    
    self.summaryLabel = [[FitLabel alloc] initWithFrame:CGRectMake(self.iconImgView.right+PagePadding, 0, 0, 0)];
    self.summaryLabel.text = @"some summary text";
    [self.summaryLabel styleTableViewRowTag];
    self.summaryLabel.numberOfLines = 1;
    [self addSubview:self.summaryLabel];
    
    self.timeLabel = [[FitLabel alloc] initWithFrame:CGRectMake(0, PagePadding, 0, 0)];
    [self.timeLabel styleTime];
    [self addSubview:self.timeLabel];

    return self;
}

-(void)setMessageDetails:(MessageDetails*)data {
    _messageDetails = data;
    self.titleLabel.text = data.message.subject;
    self.iconImgView.image = nil;
    if ([data.message.senderId isEqual:data.message.ownerId]) {
        if ([SysUser isSysUser:data.message.recipientId]) {
            self.iconImgView.image = [UIImage imageNamed:@"menu-shop"];
            self.userLabel.text = @"Next Shopper";
        }
        else if (data.userReceiverInfo) {
            [self.iconImgView setImageWithPath:data.userReceiverInfo.imgPath];
            self.userLabel.text = [NSString stringWithFormat:@"%@ %@", data.userReceiverInfo.info.firstName, data.userReceiverInfo.info.lastName];
        }
    }
    else {
        if ([SysUser isSysUser:data.message.senderId]) {
            self.iconImgView.image = [UIImage imageNamed:@"menu-shop"];
            self.userLabel.text = @"Next Shopper";
        }
        else if (data.userSenderInfo) {
            [self.iconImgView setImageWithPath:data.userSenderInfo.imgPath];
            self.userLabel.text = [NSString stringWithFormat:@"%@ %@", data.userSenderInfo.info.firstName, data.userSenderInfo.info.lastName];
        }
    }
    
    self.viewed.y = self.userLabel.y;
    self.viewed.x = self.userLabel.right + PagePadding/2;
    
    [self.titleLabel belowView:self.userLabel withMargin:5];
    [self.titleLabel extendToParentRightWithMargin:PagePadding*2];
    
    self.summaryLabel.text = data.message.content;
    //    CGSize size = [self.summaryLabel sizeThatFits:CGSizeMake(self.summaryLabel.width-PagePadding, CGFLOAT_MAX)];
    //    self.summaryLabel.height = size.height;
    [self.summaryLabel belowView:self.titleLabel withMargin:5];
    [self.summaryLabel extendToParentRightWithMargin:PagePadding*2];
    
    self.timeLabel.text = [[NSDate fromMilliseconds:data.message.created] timeAgo];
    [self.timeLabel alignParentRightWithMarghin:PagePadding];
}

@end
