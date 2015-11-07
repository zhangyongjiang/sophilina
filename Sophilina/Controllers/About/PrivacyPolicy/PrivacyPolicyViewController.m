#import "PrivacyPolicyViewController.h"
#import "PrivacyPolicyPage.h"

@interface PrivacyPolicyViewController ()

@property(strong, nonatomic)PrivacyPolicyPage* page;

@end

@implementation PrivacyPolicyViewController

-(void)createPage {
    CGFloat y = 0;
    if (self.page) {
        [self.page removeFromSuperview];
        UIView* navBar = self.navigationController.navigationBar;
        y = navBar.bottom;
    }
    self.page = [[PrivacyPolicyPage alloc] initWithFrame:self.view.bounds];
    self.page.y = y;
    [self.view addSubview:self.page];
    self.title = @"PrivacyPolicy";
}

@end
