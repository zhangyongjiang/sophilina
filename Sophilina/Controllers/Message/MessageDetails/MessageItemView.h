//
//  MessageItemView.h
//
//
//  Created by Kevin Zhang on 1/4/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MessageItemViewHeight 60*[UIView scale]
#define MessageItemCommentFont        @"GothamRounded-Light"
#define MessageItemCommentFontSize    13
#define MessageItemCommentWidth       [UIView screenWidth]-MediumUserImageViewSize-PagePadding*3


@interface MessageItemView : UIView

@property(strong,nonatomic)MessageDetails* messageDetails;

@end
