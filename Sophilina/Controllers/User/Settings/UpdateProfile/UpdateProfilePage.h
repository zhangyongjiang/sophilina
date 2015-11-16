@interface UpdateProfilePage : FormPage

@property(strong, nonatomic)LargeUserImageView* userImgView;
@property(strong, nonatomic)FullWidthTextFieldWithLabel* firstNameField;
@property(strong, nonatomic)FullWidthTextFieldWithLabel* lastNameField;
@property(strong, nonatomic)FullWidthTextFieldWithLabel* cityField;
@property(strong, nonatomic)FullWidthTextFieldWithLabel* stateField;

@property(strong, nonatomic)User* user;

@end
