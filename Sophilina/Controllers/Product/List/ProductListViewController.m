#import "ProductListViewController.h"
#import "ProductListPage.h"

@interface ProductListViewController ()

@property(strong, nonatomic)ProductListPage* page;

@end

@implementation ProductListViewController

-(void)createPage {
    CGFloat y = 0;
    if (self.page) {
        [self.page removeFromSuperview];
        UIView* navBar = self.navigationController.navigationBar;
        y = navBar.bottom;
    }
    self.page = [[ProductListPage alloc] initWithFrame:self.view.bounds];
    self.page.y = y;
    [self.view addSubview:self.page];
    [self refreshPage];
}

-(void)refreshPage {
    [ReuselocalApi ProductAPI_Mine:^(ProductDetailsList *resp) {
        self.page.ProductDetailsList = resp;
    } onError:^(APIError *err) {
    }];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"My Contributions";
}

-(void)nextPage {
}

@end
