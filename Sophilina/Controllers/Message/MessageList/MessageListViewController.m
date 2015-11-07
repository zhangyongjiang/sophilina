#import "MessageListViewController.h"
#import "MessageListPage.h"

@interface MessageListViewController ()

@property(strong, nonatomic)MessageListPage* page;
@property(assign, nonatomic)int currentPage;

@end

@implementation MessageListViewController

-(void)createPage {
    CGFloat y = 0;
    if (self.page) {
        [self.page removeFromSuperview];
        UIView* navBar = self.navigationController.navigationBar;
        y = navBar.bottom;
    }
    self.page = [[MessageListPage alloc] initWithFrame:self.view.bounds];
    self.page.y = y;
    [self.view addSubview:self.page];
    self.title = @"Messages";
    [self refreshPage];
}

-(void)more {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"Mark All Read" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [ReuselocalApi MessageAPI_MarkAllUserMsgAsRead:^(GenericResponse *resp) {
            [self refreshPage];
        } onError:^(APIError *err) {
        }];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }]];
    
    [[AppDelegate getInstance] presentViewController:alert completion:^{
    }];
}

-(void)refreshPage {
    self.currentPage = 0;
    [ReuselocalApi MessageAPI_GetUserMessages:[NSNumber numberWithInt:self.currentPage*PageSize] size:[NSNumber numberWithInt:PageSize] onSuccess:^(MessageDetailsList *resp) {
        [[AppDelegate getInstance] setBadgeNumber:resp.totalUnread.intValue];
//        if (resp.totalUnread.intValue > 0) {
//            [self addNavRightImgButton:[UIImage imageNamed:@"more"] target:self action:@selector(more)];
//        }
//        else {
//            [self removeNavRightButton];
//        }
        [self.page setMessageDetailsList:resp];
    } onError:^(APIError *err) {
    }];
}

-(void)handleEvent:(NSString *)name fromSource:(NSObject *)source data:(NSObject *)data {
    if ([name isEqualToString:NotificationMsgChanged]) {
        NSNumber* num = (NSNumber*)data;
//        if (num.intValue > 0) {
//            [self addNavRightImgButton:[UIImage imageNamed:@"more"] target:self action:@selector(more)];
//        }
//        else {
//            [self removeNavRightButton];
//        }
    }
}

-(void)nextPage {
    if(![self hasNextPage:PageSize current:self.currentPage currentItems:self.page.messageDetailsList.items.count]) {
        return;
    }
    self.currentPage++;
    [ReuselocalApi MessageAPI_GetUserMessages:[NSNumber numberWithInt:self.currentPage*PageSize] size:[NSNumber numberWithInt:PageSize] onSuccess:^(MessageDetailsList *resp) {
        [self.page appendMessageDetailsList:resp toIndex:self.currentPage*PageSize];
    } onError:^(APIError *err) {
    }];
}
@end
