#import "CreateProductViewController.h"
#import "CreateProductPage.h"
#import "MessageListViewController.h"
#import "ProductListViewController.h"

@interface CreateProductViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(strong, nonatomic)CreateProductPage* page;
@property(strong, nonatomic)Product* product;

@end

@implementation CreateProductViewController

-(void)createPage {
    self.automaticallyAdjustsScrollViewInsets = NO;
    CGFloat y = 0;
    if (self.page) {
        [self.page removeFromSuperview];
        UIView* navBar = self.navigationController.navigationBar;
        y = navBar.bottom;
    }
    self.page = [[CreateProductPage alloc] initWithFrame:self.view.bounds];
    self.page.y = y;
    self.page.textFieldContent.text = self.body;
    self.page.textFieldSubject.text = self.subject;
    self.page.textFieldSubject.userInteractionEnabled = YES;
    [self.view addSubview:self.page];
    self.title = @"Contact Seller";
    [self addNavRightButton:@"Send" target:self action:@selector(sendImages)];
    [self.page.cameraView addTarget:self action:@selector(selectImage)];
    [self.page.labelAttachment addTarget:self action:@selector(selectImage)];
    
    self.product = [[Product alloc] init];
    self.product.info = [[ProductInfo alloc] init];
    
    User* user = [NSUserDefaults savedUser];
    if (user) {
        self.page.labelLocation.text = [NSString stringWithFormat:@"%@, %@", user.info.city, user.info.state];
        self.product.location.city = user.info.city;
        self.product.location.state = user.info.state;
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"Give Free";
}

-(void)selectImage {
    [self loadCameraOrPhotoLibraryWithDelegate:self allowEditing:NO];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *selectedImage = info[UIImagePickerControllerEditedImage];
    if(!selectedImage)
        selectedImage = info[UIImagePickerControllerOriginalImage];
    [self.page addImage:selectedImage];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

-(void)sendMsg {
    self.product.info.name = self.page.textFieldSubject.text;
    self.product.info.details = self.page.textFieldContent.text;
    [ReuselocalApi ProductAPI_CreateProduct:self.product onSuccess:^(Product *resp) {
        ProductListViewController* controller = [[ProductListViewController alloc] init];
        [[AppDelegate getInstance] startPage:controller];
    } onError:^(APIError *err) {
        
    }];
}

-(void)sendImages {
    if (!self.page.images || !self.page.images.count) {
        [self sendMsg];
    }
    for (UIImageView* imgView in self.page.images) {
        [WebService upload:UIImagePNGRepresentation(imgView.image) onSuccess:^(Resource *resp) {
            if (!self.product.imgs) {
                self.product.imgs = [[NSMutableArray alloc] init];
            }
            [self.product.imgs addObject:resp.path];
            if (self.product.imgs.count >= self.page.images.count) {
                [self sendMsg];
            }
        } onError:^(APIError *err) {
        }];
    }
}

@end
