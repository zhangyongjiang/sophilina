//
//  MessageListPage.m
//
//
//  Created by Kevin Zhang on 11/16/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "MessageListPage.h"
#import "MessageListItemTableViewCell.h"
#import "MessageDetailsViewController.h"
#import "EmptyPage.h"

#define MessageListItemTableViewCellID @"MessageListItemTableViewCellID"

@interface MessageListPage()

@property(strong,nonatomic)EmptyPage* emptyPage;

@end

@implementation MessageListPage

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [_tableView registerClass:[MessageListItemTableViewCell class] forCellReuseIdentifier:MessageListItemTableViewCellID];
    [self createEmptyView];
    return self;
}

-(void)createEmptyView {
    self.emptyPage = [[EmptyPage alloc] initWithFrame:self.frame];
    self.emptyPage.imgView.image = [UIImage imageNamed:@"empty-messages"];
    self.emptyPage.label.text = @"You don't have message.";
    self.emptyPage.hidden = YES;
    _tableView.backgroundView = self.emptyPage;
    
}

-(void)setMessageDetailsList:(MessageDetailsList*)pageData {
    _messageDetailsList = pageData;
    [_tableView reloadData];
    self.emptyPage.hidden = !(pageData.items.count == 0);
}

-(void)appendMessageDetailsList:(MessageDetailsList *)messageDetailsList  toIndex:(int)index {
    [_messageDetailsList.items removeObjectsInRange:NSMakeRange(index, _messageDetailsList.items.count-index)];
    [_messageDetailsList.items addObjectsFromArray:messageDetailsList.items];
    [_tableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messageDetailsList.items.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [super checkNextPageForTableView:tableView indexPath:indexPath];
    MessageListItemTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:MessageListItemTableViewCellID];
    MessageDetails* msgDetails = [self.messageDetailsList.items objectAtIndex:indexPath.row];
    [cell setMessageDetails:msgDetails];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return MessageListItemViewHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageDetails* msgDetails = [self.messageDetailsList.items objectAtIndex:indexPath.row];
    MessageDetailsViewController* controller = [[MessageDetailsViewController alloc] init];
    controller.msgId = msgDetails.message.id;
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationPushController object:self userInfo:[NSMutableDictionary dictionaryWithObject:controller forKey:@"controller"]];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        MessageDetails* msgDetails = [self.messageDetailsList.items objectAtIndex:indexPath.row];
        [ReuselocalApi MessageAPI_DeleteUserMessage:msgDetails.message.id onSuccess:^(GenericResponse *resp) {
            [self.messageDetailsList.items removeObjectAtIndex:indexPath.row];
            [tableView reloadData];
        } onError:^(APIError *err) {
            [tableView reloadData];
        }];
    }
}

@end
