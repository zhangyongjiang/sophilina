#import "MessageDetailsViewController.h"
#import "MessageDetailsPage.h"
#import "NewMessageViewController.h"
#import "MessageReplyViewController.h"

@interface MessageDetailsViewController ()

@property(strong, nonatomic)MessageDetailsPage* page;

@end

@implementation MessageDetailsViewController

-(void)createPage {
    CGFloat y = 0;
    if (self.page) {
        [self.page removeFromSuperview];
        UIView* navBar = self.navigationController.navigationBar;
        y = navBar.bottom;
    }
    self.page = [[MessageDetailsPage alloc] initWithFrame:self.view.bounds];
    self.page.y = y;
    [self.view addSubview:self.page];
    self.title = @"Message Thread";
    [self addNavRightButton:@"Reply" target:self action:@selector(reply)];
    [self refreshPage];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

-(void)refreshPage {
    [ReuselocalApi MessageAPI_GetUserMessageThreadsByMsgId:self.msgId onSuccess:^(MessageThread *resp) {
        self.page.messageThread = resp;
    } onError:^(APIError *err) {
        err.processed = YES;
        [self alertWithTitle:@"Oops" andMsg:@"System error. Please try again later." handler:nil];
        NSLog(@"error get msg %@", err);
    }];
}

-(void)reply {
    MessageReplyViewController* controller = [[MessageReplyViewController alloc] init];
    controller.msgId = self.msgId;
    [self.navigationController pushViewController:controller animated:YES];
}
@end
