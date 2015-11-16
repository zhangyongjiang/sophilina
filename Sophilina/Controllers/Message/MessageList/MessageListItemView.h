//
//  ProductView.h
//
//
//  Created by Kevin Zhang on 1/3/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MessageListItemViewHeight 80*[UIView scale]

@interface MessageListItemView : UIView

@property(strong,nonatomic)MessageDetails* messageDetails;

@end
