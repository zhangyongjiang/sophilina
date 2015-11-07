#import "ContactNextShopperViewController.h"
#import "ContactNextShopperPage.h"
#import "MessageListViewController.h"

@interface ContactNextShopperViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(strong, nonatomic)ContactNextShopperPage* page;
@property(strong, nonatomic)Message* msg;

@end

@implementation ContactNextShopperViewController

-(void)createPage {
    self.automaticallyAdjustsScrollViewInsets = NO;
    CGFloat y = 0;
    if (self.page) {
        [self.page removeFromSuperview];
        UIView* navBar = self.navigationController.navigationBar;
        y = navBar.bottom;
    }
    self.page = [[ContactNextShopperPage alloc] initWithFrame:self.view.bounds];
    self.page.y = y;
    self.page.textFieldContent.text = self.body;
    self.page.textFieldSubject.text = self.subject;
    [self.view addSubview:self.page];
    self.title = @"Contact NextShopper";
    [self addNavRightButton:@"Send" target:self action:@selector(sendImages)];
    [self.page.cameraView addTarget:self action:@selector(selectImage)];
    [self.page.labelAttachment addTarget:self action:@selector(selectImage)];
    
    self.msg = [[Message alloc] init];
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
    self.msg.content = self.page.textFieldContent.text;
    self.msg.subject = self.page.textFieldSubject.text;
    
    [ReuselocalApi MessageAPI_UserToSystemMessage:self.msg onSuccess:^(Message *resp) {
        [self alertWithTitle:@"Message Sent" andMsg:@"We will get back to you within 48 hours." handler:^(UIAlertAction *action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } onError:^(APIError *err) {
        [self alertWithTitle:@"Oops" andMsg:@"Please try again later" handler:nil];
        err.processed = YES;
    }];
}

-(void)sendImages {
    [self.view endEditing:YES];

    if (!self.page.images || !self.page.images.count) {
        [self sendMsg];
    }
    for (UIImageView* imgView in self.page.images) {
        [WebService upload:UIImagePNGRepresentation(imgView.image) onSuccess:^(Resource *resp) {
            if (!self.msg.attachments) {
                self.msg.attachments = [[NSMutableArray alloc] init];
            }
            [self.msg.attachments addObject:resp.path];
            if (self.msg.attachments.count == self.page.images.count) {
                [self sendMsg];
            }
        } onError:^(APIError *err) {
        }];
    }
}

@end
