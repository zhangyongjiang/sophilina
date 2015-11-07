#import "FAQViewController.h"
#import "FAQPage.h"

@interface FAQViewController ()

@property(strong, nonatomic)FAQPage* page;

@end

@implementation FAQViewController

-(void)createPage {
    CGFloat y = 0;
    if (self.page) {
        [self.page removeFromSuperview];
        UIView* navBar = self.navigationController.navigationBar;
        y = navBar.bottom;
    }
    
    self.page = [[FAQPage alloc] initWithFrame:self.view.bounds];
    self.page.y = y;
    [self.view addSubview:self.page];
    self.title = @"FAQ";
}

@end
