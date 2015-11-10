//
//  SignupPage.m
//
//
//  Created by Kevin Zhang on 11/17/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "SignupPage.h"

@interface SignupPage() <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
@property(strong, nonatomic)UIView* avatarRow;
//@property(strong,nonatomic)UIPickerView* pickerView;
@end

@implementation SignupPage

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    [self setBackgroundImage:@"signup-bg"];
//    [self show:@"animated-500x620" width:500 height:620 x:0 y:0 toView:self.scrollView];
//    [self show:@"animated-640x360" width:640 height:360 x:-450 y:0 toView:self.scrollView];
//    [self show:@"animated-800x540" width:800 height:540 x:0 y:0 toView:self.scrollView];
    
    self.headerLabel.text = @"Sign Up";
    
//    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, [UIView screenWidth], 50)];
//    self.pickerView.accessibilityLabel = @"pickerView";
//    self.pickerView.delegate = self;
//    self.pickerView.dataSource = self;
//    self.pickerView.backgroundColor = [UIColor lightGrayColor];
//    [self.pickerView selectRow:1 inComponent:0 animated:NO];
    
    self.firstNameField = [[FormTextField alloc] init];
    self.firstNameField.accessibilityLabel = @"firstNameField";
    self.firstNameField.placeholder = @"First Name";
    self.firstNameField.width = HalfWidthExcludePadding2;
    [self.scrollView addSubview:self.firstNameField];
    
    self.lastNameField = [[FormTextField alloc] init];
    self.lastNameField.accessibilityLabel = @"lastNameField";
    self.lastNameField.placeholder = @"Last Name";
    self.lastNameField.width = HalfWidthExcludePadding2;
    [self.scrollView addSubview:self.lastNameField];
    
    self.emailField = [[FullWidthField alloc] init];
    self.emailField.accessibilityLabel = @"emailField";
    self.emailField.placeholder = @"Email";
    [self.scrollView addSubview:self.emailField];
    
    self.passwordField = [[PasswordField alloc] init];
    self.passwordField.accessibilityLabel = @"passwordField";
    self.passwordField.placeholder = @"Password. Min. 6 characters";
    self.passwordField.width = FullWidthExcludePadding;
    [self.scrollView addSubview:self.passwordField];
    
//    self.genderField = [[FullWidthField alloc] init];
//    self.genderField.accessibilityLabel = @"genderField";
//    self.genderField.placeholder = @"Gender (optional)";
//    [self.scrollView addSubview:self.genderField];
//    self.genderField.inputView = self.pickerView;
    
    self.avatarRow = [[UIView alloc] init];
    self.avatarRow.backgroundColor = [UIColor whiteColor];
    self.avatarRow.height = 88 * [UIView scale];
    self.avatarRow.width = FullWidthExcludePadding;
    [self.scrollView addSubview:self.avatarRow];

    self.userImgView = [[LargeUserImageView alloc] init];
    [self.avatarRow addSubview:self.userImgView];
    
    self.clickToUploadLabel = [[FitLabel alloc] init];
    self.clickToUploadLabel.accessibilityLabel = @"clickToUploadLabel";
    self.clickToUploadLabel.text = @"Tap to upload your photo";
    [self.clickToUploadLabel styleContent];
    [self.avatarRow addSubview:self.clickToUploadLabel];
    
    self.firstNameField.y = FormTopMargin;
    self.lastNameField.y = FormTopMargin;
    [self.lastNameField alignParentRightWithMarghin:PagePadding];
    
    [UIView setLeftMargin:PagePadding views:self.firstNameField, self.emailField, self.passwordField, /*self.genderField,*/ self.avatarRow, nil];
    [UIView top2bottomWithMargin:1 views:self.firstNameField, self.emailField, self.passwordField, /*self.genderField, */ self.avatarRow, nil];
    
    [self.userImgView vcenterInParent];
    self.userImgView.x = PagePadding * [UIView scale];
    [self.clickToUploadLabel vcenterInParent];
    [self.clickToUploadLabel rightOfView:self.userImgView withMargin:PagePadding * [UIView scale]];
    
    UIView* containerView = [self maskViews:[NSArray arrayWithObjects:self.firstNameField, self.lastNameField, self.emailField, self.passwordField/*, self.genderField*/, self.avatarRow, nil]];
    [self.scrollView addSubview:containerView];
    
    
    UIButton* signupBtn = [self createActionButton:@"Join" image:nil bgcolr:[UIColor clearColor]];
    [self.scrollView addSubview:signupBtn];
    [signupBtn belowView:containerView withMargin:24*[UIView scale]];
    self.signupBtn = signupBtn;
    
    FitLabel* label = [[FitLabel alloc] init];
    label.numberOfLines = 2;
    label.textAlignment = NSTextAlignmentCenter;
    [label h4];[label white];
    NSString* tos = @"By joining NextShopper,\nyou agree to the";
    label.text = tos;
    [self.scrollView addSubview:label];
    [label hcenterInParent];
    [label belowView:containerView withMargin:80*[UIView scale]];
    
    self.tosLabel = [[FitLabel alloc] init];
    self.tosLabel.accessibilityLabel = @"tosLabel";
    self.tosLabel.textAlignment = NSTextAlignmentCenter;
    [self.tosLabel h3];
    self.tosLabel.textColor = [UIColor whiteColor];
    self.tosLabel.text = @"Terms of Service";
    self.tosLabel.y = label.bottom + 3;
    [self.scrollView addSubview:self.tosLabel];
    
    self.policyLabel = [[FitLabel alloc] init];
    self.policyLabel.accessibilityLabel = @"policyLabel";
    self.policyLabel.textAlignment = NSTextAlignmentCenter;
    [self.policyLabel h3];
    self.policyLabel.textColor = [UIColor whiteColor];
    self.policyLabel.text = @"Privacy Policy";
    self.policyLabel.y = label.bottom + 3;
    [self.scrollView addSubview:self.policyLabel];
    
    FitLabel* andlabel = [[FitLabel alloc] init];
    andlabel.numberOfLines = 2;
    andlabel.textAlignment = NSTextAlignmentCenter;
    [andlabel h4]; [andlabel white];
    andlabel.text = @" and ";
    andlabel.y = label.bottom + 3;
    [self.scrollView addSubview:andlabel];
    [self.scrollView hcenterMargin:0 forSubviews:self.tosLabel, andlabel, self.policyLabel, nil];
    
    return self;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
//    if(row == 0)
//        self.genderField.text = @"Not to Say";
//    else if(row == 1)
//        self.genderField.text = @"Male";
//    else
//        self.genderField.text = @"Female";
//    [self.genderField endEditing:YES];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 3;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(row == 0)
        return @"Not to Say";
    if(row == 1)
        return @"Male";
    return @"Female";
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 300;
    
    return sectionWidth;
}

@end
