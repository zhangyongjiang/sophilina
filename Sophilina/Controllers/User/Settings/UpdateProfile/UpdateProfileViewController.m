//
//  SettingsViewController.m
//
//
//  Created by Kevin Zhang on 11/19/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "UpdateProfileViewController.h"
#import "UpdateProfilePage.h"

@interface UpdateProfileViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(strong,nonatomic)UpdateProfilePage* page;

@end

@implementation UpdateProfileViewController

-(void)createPage {
    self.automaticallyAdjustsScrollViewInsets = NO;
    CGFloat y = 0;
    if (self.page) {
        [self.page removeFromSuperview];
        UIView* navBar = self.navigationController.navigationBar;
        y = navBar.bottom;
    }
    
    self.page = [[UpdateProfilePage alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.page];
    self.page.user = [NSUserDefaults savedUser];
    [self.page.userImgView addTarget:self action:@selector(changeAvatar)];
    [self addNavRightButton:@"Save" target:self action:@selector(saveUser)];
    
    self.title = @"Profile";
    self.scrollView = self.page.scrollView;
}

-(void)changeAvatar {
    [self loadCameraOrPhotoLibraryWithDelegate:self allowEditing:YES];
}

-(void)saveUser {
    [self.view endEditing:YES];

    UserBasicInfo* req = [[UserBasicInfo alloc] init];
    req.firstName = self.page.firstNameField.text;
    req.lastName = self.page.lastNameField.text;
    req.city = self.page.cityField.text;
    req.state = self.page.stateField.text;
    [WebService UserAPI_Update:req onSuccess:^(User *resp) {
        [self.navigationController popViewControllerAnimated:YES];
    } onError:^(APIError *err) {
        
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *selectedImage = info[UIImagePickerControllerEditedImage];
    if(!selectedImage)
        selectedImage = info[UIImagePickerControllerOriginalImage];
    NSData *imageData = [self compress:selectedImage];
    [WebService uploadUserAvatar:imageData onSuccess:^(User *resp) {
        self.page.user = resp;
    } onError:^(APIError *err) {
    }];
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

@end
