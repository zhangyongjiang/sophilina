#import "NewMessageViewController.h"
#import "NewMessagePage.h"
#import "MessageListViewController.h"

@interface NewMessageViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(strong, nonatomic)NewMessagePage* page;
@property(strong, nonatomic)Message* msg;

@end

@implementation NewMessageViewController

-(void)createPage {
    self.automaticallyAdjustsScrollViewInsets = NO;
    CGFloat y = 0;
    if (self.page) {
        [self.page removeFromSuperview];
        UIView* navBar = self.navigationController.navigationBar;
        y = navBar.bottom;
    }
    self.page = [[NewMessagePage alloc] initWithFrame:self.view.bounds];
    self.page.y = y;
    self.page.textFieldContent.text = self.body;
    self.page.textFieldSubject.text = self.subject;
    self.page.textFieldSubject.userInteractionEnabled = YES;
    [self.view addSubview:self.page];
    self.title = @"Contact Seller";
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
    if (self.messageType == User2Store) {
    }
}

-(void)sendImages {
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
