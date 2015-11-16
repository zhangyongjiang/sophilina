#import "ChangePasswordViewController.h"
#import "ChangePasswordPage.h"

@interface ChangePasswordViewController ()

@property(strong,nonatomic)ChangePasswordPage* page;

@end

@implementation ChangePasswordViewController

-(void)createPage {
    self.automaticallyAdjustsScrollViewInsets = NO;
    CGFloat y = 0;
    if (self.page) {
        [self.page removeFromSuperview];
        UIView* navBar = self.navigationController.navigationBar;
        y = navBar.bottom;
    }

    self.page = [[ChangePasswordPage alloc] initWithFrame:self.view.bounds];
    self.page.y = y;
    [self.view addSubview:self.page];
    self.title = @"Change Password";
    [self addNavRightButton:@"Save" target:self action:@selector(changePassword)];
}

-(void)changePassword {
    if (![self.page.confirmPasswordField.text isEqualToString:self.page.passwordField.text]) {
        [self alertWithTitle:@"Oops" andMsg:@"password doesn't match"];
//        [[iToast makeText:@"password doesn't match"] show];
        return;
    }
    if (!self.page.oldPasswordField.text) {
        [self alertWithTitle:@"Error" andMsg:@"Current password is required"];
//        [[iToast makeText:@"Current password is required"] show];
        return;
    }
    
    ChangePasswordRequest *req = [[ChangePasswordRequest alloc] init];
    req.oldPassword = self.page.oldPasswordField.text;
    req.password = self.page.passwordField.text;
    
    if (req.password.length < 6) {
        [self alertWithTitle:@"Oops" andMsg:@"Min length for password 6 characters." handler:nil];
        return;
    }
    
    [ReuselocalApi UserAPI_ChangePassword:req onSuccess:^(GenericResponse *resp) {
        [self alertWithTitle:@"Info" andMsg:@"Password changed"];
//        [[iToast makeText:@"Password changed"] show];
        [self.navigationController popViewControllerAnimated:YES];
    } onError:^(APIError *err) {
        if ([err.errorCode isEqualToString:@"InvalidPassword"]) {
            [self alertWithTitle:@"Oops" andMsg:@"Invalid password." handler:^(UIAlertAction *action) {
            }];
            err.processed = YES;
        }
        [self alertWithTitle:@"Info" andMsg:@"System error. Please try again later."];
//        [[iToast makeText:@"System error. Please try again later."] show];
        err.processed = YES;
    }];
}
@end
