#import "TermOfUseViewController.h"
#import "TermOfUsePage.h"

@interface TermOfUseViewController ()

@property(strong, nonatomic)TermOfUsePage* page;

@end

@implementation TermOfUseViewController

-(void)createPage {
    CGFloat y = 0;
    if (self.page) {
        [self.page removeFromSuperview];
        UIView* navBar = self.navigationController.navigationBar;
        y = navBar.bottom;
    }
    self.page = [[TermOfUsePage alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.page];
    self.title = @"TermOfUse";
}

@end
