#import "ProductDetailsViewController.h"
#import "ProductDetailsPage.h"
#import "WelcomeViewController.h"
#import "UpdateProductViewController.h"

@interface ProductDetailsViewController () <UIViewEventDelegate>

@property(strong, nonatomic)ProductDetailsPage* page;

@end

@implementation ProductDetailsViewController

-(void)createPage {
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.transparentNavbar = YES;
    CGFloat y = 0;
    if (self.page) {
        [self.page removeFromSuperview];
        UIView* navBar = self.navigationController.navigationBar;
        y = navBar.bottom;
    }
    self.page = [[ProductDetailsPage alloc] initWithFrame:self.view.bounds];
    self.page.y = y;
    [self.view addSubview:self.page];
    
    [self refreshPage];

    [self.page setEventDelegate:self];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"Details";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productChanged:) name:NotificationProductChanged object:nil];
}


-(void)refreshPage {
    self.page.hidden = YES;
    [ReuselocalApi ProductAPI_Get:self.productId onSuccess:^(ProductDetails *resp) {
        self.page.prodDetails = resp;
        self.page.hidden = NO;
        
        User* me = [NSUserDefaults savedUser];
        if (me && [resp.product.userId isEqualToString:me.id]) {
            [self addNavRightButton:@"Edit" target:self action:@selector(editProduct)];
        }
    } onError:^(APIError *err) {
        self.page.hidden = NO;
    }];
}

-(void)editProduct {
    UpdateProductViewController* controller = [[UpdateProductViewController alloc] init];
    controller.product = self.page.prodDetails.product;
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)productChanged:(NSNotification*)noti {
    NSString* productId = noti.object;
    if ([productId isEqualToString:self.productId]) {
        [self refreshPage];
    }
}

@end
