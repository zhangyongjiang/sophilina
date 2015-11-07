#import "Page.h"

@interface MessageListPage : TableViewPage

@property(strong, nonatomic)MessageDetailsList* messageDetailsList;

-(void)appendMessageDetailsList:(MessageDetailsList*) messageDetailsList toIndex:(int)index;

@end
