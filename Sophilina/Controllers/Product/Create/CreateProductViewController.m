#import "CreateProductViewController.h"
#import "CreateProductPage.h"
#import "MessageListViewController.h"

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
    self.product.info._description = self.page.textFieldContent.text;
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
            if (self.product.imgs.count == self.page.images.count) {
                [self sendMsg];
            }
        } onError:^(APIError *err) {
        }];
    }
}

@end
