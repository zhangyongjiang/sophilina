#import "MessageReplyViewController.h"
#import "MessageReplyPage.h"
#import "MessageListViewController.h"
#import "iToast.h"

@interface MessageReplyViewController ()

@property(strong, nonatomic)MessageReplyPage* page;
@property(strong, nonatomic)MessageDetails* messageDetails;
@property(strong, nonatomic)Message* msg;

@end

@implementation MessageReplyViewController

-(void)createPage {
    self.automaticallyAdjustsScrollViewInsets = NO;
    CGFloat y = 0;
    if (self.page) {
        [self.page removeFromSuperview];
        UIView* navBar = self.navigationController.navigationBar;
        y = navBar.bottom;
    }
    self.page = [[MessageReplyPage alloc] initWithFrame:self.view.bounds];
    self.page.y = y;
    [self.view addSubview:self.page];
    self.title = @"Reply";
    [self addNavRightButton:@"Send" target:self action:@selector(sendImages)];
    [self.page.cameraView addTarget:self action:@selector(selectImage)];
    [self.page.labelAttachment addTarget:self action:@selector(selectImage)];
    [self refreshPage];
    self.msg = [[Message alloc] init];
}

-(void)refreshPage {
    [ReuselocalApi MessageAPI_GetUserMessageById:self.msgId onSuccess:^(MessageDetails *resp) {
        self.messageDetails = resp;
        [self.page setOriginalMessage:resp];
    } onError:^(APIError *err) {
    }];
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
    self.msg.subject = self.page.textFieldSubject.text;
    self.msg.content = self.page.textFieldContent.text;
    self.msg.recipientId = self.messageDetails.message.senderId;
    self.msg.orderId = self.messageDetails.message.orderId;
    
    [ReuselocalApi MessageAPI_UserReplyMessage:self.msgId msg:self.msg onSuccess:^(Message *resp) {
        [[iToast makeText:@"Message Sent"] show];
        [self.navigationController popViewControllerAnimated:YES];
        BaseViewController* controller = self.navigationController.topViewController;
        [controller refreshPage];
        
//        MessageListViewController* controller = [[MessageListViewController alloc] init];
//        [[AppDelegate getInstance] showViewController:controller];
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
