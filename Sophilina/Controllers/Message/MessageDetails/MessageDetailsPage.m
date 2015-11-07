//
//  MessageDetailsPage.m
//
//
//  Created by Kevin Zhang on 11/16/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "MessageDetailsPage.h"
#import "MessageThreadItemView.h"
#import "MessageItemView.h"

@interface MessageDetailsPage()

@property(strong,nonatomic)UIScrollView* scrollView;

@end

@implementation MessageDetailsPage

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:self.scrollView];
    return self;
}

-(void)setMessageThread:(MessageThread*)messageThread {
    _messageThread = messageThread;
    CGFloat y = 0;
    CGFloat padding = 5 * [UIView scale];
    
    UILabel* title = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, [UIView screenWidth], 0)];
    title.paddingLeft = PagePadding;
    title.lineBreakMode = NSLineBreakByWordWrapping;
    [title styleTableViewRowLabel];
    title.numberOfLines = 0;
    MessageDetails* first = [messageThread.items objectAtIndex:0];
    title.text = first.message.subject;
    [title fitHeight];
    [self.scrollView addSubview:title];
    y = title.bottom + 20;

    NSString* orderId = nil;
    for (MessageDetails* msg in messageThread.items) {
        MessageItemView* view = [[MessageItemView alloc] initWithFrame:CGRectMake(0, y, self.width, 0)];
        [self.scrollView addSubview:view];
        view.messageDetails = msg;
        y = y + view.height + padding;
        orderId = msg.message.orderId;
    }
    
    if (orderId) {
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIView screenWidth], title.bottom+20)];
        view.backgroundColor = [UIColor clearColor];
        [self.scrollView addSubview:view];
        [view addTarget:self action:@selector(gotoOrder:)];
    }
    
    self.scrollView.contentSize = CGSizeMake(self.width, y);
}

-(void)gotoOrder:(id)sender {
    MessageDetails* msg = [self.messageThread.items objectAtIndex:0];
    NSString* orderId = msg.message.orderId;
}
@end
