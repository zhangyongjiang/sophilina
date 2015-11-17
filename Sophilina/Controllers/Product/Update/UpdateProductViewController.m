#import "UpdateProductViewController.h"
#import "UpdateProductPage.h"
#import "MessageListViewController.h"
#import "ProductListViewController.h"

@interface UpdateProductViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(strong, nonatomic)UpdateProductPage* page;

@end

@implementation UpdateProductViewController

-(void)createPage {
    self.automaticallyAdjustsScrollViewInsets = NO;
    CGFloat y = 0;
    if (self.page) {
        [self.page removeFromSuperview];
        UIView* navBar = self.navigationController.navigationBar;
        y = navBar.bottom;
    }
    self.page = [[UpdateProductPage alloc] initWithFrame:self.view.bounds];
    self.page.product = self.product;
    self.page.y = y;
    self.page.textFieldSubject.userInteractionEnabled = YES;
    [self.view addSubview:self.page];
    [self addNavRightButton:@"Update" target:self action:@selector(updateProduct)];
    [self.page.cameraView addTarget:self action:@selector(selectImage)];
    [self.page.labelAttachment addTarget:self action:@selector(selectImage)];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"Edit";
}

-(void)selectImage {
    [self loadCameraOrPhotoLibraryWithDelegate:self allowEditing:NO];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *selectedImage = info[UIImagePickerControllerEditedImage];
    if(!selectedImage)
        selectedImage = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    UIImageView* imgView = [self.page addImage:selectedImage];
    [WebService uploadImage:UIImagePNGRepresentation(selectedImage) forProduct:self.product.id onSuccess:^(Product *prod) {
        NSString* path = [prod.imgs objectAtIndex:(prod.imgs.count-1)];
        [imgView attachObject:path forKey:@"path"];
    } onError:^(APIError *err) {
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

-(void)updateProduct {
    self.product.info.name = self.page.textFieldSubject.text;
    self.product.info.details = self.page.textFieldContent.text;
    [ReuselocalApi ProductAPI_Update:self.product.id info:self.product.info onSuccess:^(Product *resp) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationProductChanged" object:resp.id];
    } onError:^(APIError *err) {
        
    }];
}

@end
