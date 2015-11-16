#import "SignupViewController.h"
#import "HomeViewController.h"

@interface SignupViewController ()

@end

@implementation SignupViewController

-(void)createPage {
    self.transparentNavbar = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.title = @"Sign Up";
    CGFloat y = 0;
    if (self.page) {
        [self.page removeFromSuperview];
        UIView* navBar = self.navigationController.navigationBar;
        y = navBar.bottom;
    }
    
    self.page = [[SignupPage alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.page];
    
//    [self addNavRightButton:@"Join" target:self action:@selector(btnClicked)];
    [self.page.userImgView addTarget:self action:@selector(uploadAvatar)];
    [self.page.signupBtn addTarget:self action:@selector(btnClicked)];
    [self.page.clickToUploadLabel addTarget:self action:@selector(uploadAvatar)];
    [self.page.tosLabel addTarget:self action:@selector(gotoTos)];
    [self.page.policyLabel addTarget:self action:@selector(gotoPrivacy)];
    self.scrollView = self.page.scrollView;
}

-(void)btnClicked {
    [self.view endEditing:YES];
    RegisterRequest *req = [[RegisterRequest alloc] init];
    req.firstName = self.page.firstNameField.text;
    req.lastName = self.page.lastNameField.text;
    req.email = self.page.emailField.text;
    req.password = self.page.passwordField.text;
    req.city = self.page.cityField.text;
    req.state = self.page.stateField.text;
    
    if (req.firstName.length == 0 || req.lastName.length == 0 || req.email.length == 0 || req.password.length == 0 || req.city.length == 0 || req.state.length == 0) {
        [self alertWithTitle:@"Oops" andMsg:@"First name, last name, email, password, city and state are required." handler:nil];
        return;
    }
    if (req.password.length < 6) {
        [self alertWithTitle:@"Oops" andMsg:@"Min length for password 6 characters." handler:nil];
        return;
    }
    AFHTTPRequestOperation* operation = [WebService UserAPI_Register:req onSuccess:^(User *user) {
        if (self.page.imageData) {
            [WebService uploadUserAvatar:self.page.imageData onSuccess:^(User *resp) {
                [[AppDelegate getInstance] resumePage];
            } onError:^(APIError *err) {
                [[AppDelegate getInstance] alertWithTitle:@"Oops" andMsg:@"Registration succeed but upload failed. Please try to upload again later on your profile page." handler:^(UIAlertAction *action) {
                    [[AppDelegate getInstance] resumePage];
                }];
//                [[iToast makeText:@"Upload failed"] show];
                err.processed = YES;
            }];

        }
        else {
            [[AppDelegate getInstance] resumePage];
        }
    } onError:^(APIError *err) {
        if([err isDuplicated]) {
            [[AppDelegate getInstance] alertWithTitle:@"Oops" andMsg:@"Email is taken" handler:^(UIAlertAction *action) {
                
            }];
            err.processed = YES;
        }
        else if ([err isInvalidInput]) {
            [[AppDelegate getInstance] alertWithTitle:@"Oops" andMsg:err.errorMsg handler:^(UIAlertAction *action) {
                
            }];
            err.processed = YES;
        }
        else  {
            [[AppDelegate getInstance] alertWithTitle:@"Oops" andMsg:err.errorCode handler:^(UIAlertAction *action) {
                
            }];
            err.processed = YES;
        }
    }];
}

-(void)uploadAvatar {
    [self loadCameraOrPhotoLibraryWithDelegate:self allowEditing:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *selectedImage = info[UIImagePickerControllerEditedImage];
    if(!selectedImage)
        selectedImage = info[UIImagePickerControllerOriginalImage];
    
    self.page.imageData = [self compress:selectedImage];
    [self.page.userImgView setImage:[UIImage imageWithData:self.page.imageData]];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

-(NSData*)compress:(UIImage*)image {
    int kMaxUploadSize = 150000;
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    NSData* imageData;
    do {
        imageData = UIImageJPEGRepresentation(image, compression);
        compression -= 0.10;
    } while ([imageData length] > kMaxUploadSize && compression > maxCompression);
    
    return imageData;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

-(void)gotoTos {
    WebViewController* controller = [[WebViewController alloc] initWithUrl:@"tos/index.jsp.oo" andTitle:@"Terms of Service"];
    [self.navigationController pushViewController:controller animated:YES];
    
}

-(void)gotoPrivacy {
    WebViewController* controller = [[WebViewController alloc] initWithUrl:@"privacy-policy/index.jsp.oo" andTitle:@"Privacy Policy"];
    [self.navigationController pushViewController:controller animated:YES];
    
}

@end
