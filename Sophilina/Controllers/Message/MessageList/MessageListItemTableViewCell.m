//
//  OrderItemTableViewCell.m
//
//
//  Created by Kevin Zhang on 1/3/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "MessageListItemTableViewCell.h"

@interface MessageListItemTableViewCell()

@property(strong,nonatomic)MessageListItemView* view;

@end

@implementation MessageListItemTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.view = [[MessageListItemView alloc] initWithFrame:CGRectMake(0, 0, FullWidth, MessageListItemViewHeight)];
    [self.contentView addSubview:self.view];
    return self;
}

-(void)setMessageDetails:(MessageDetails *)data {
    [self.view setMessageDetails:data];
}
@end
