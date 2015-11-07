//
//  NewMessagePage.m
//
//
//  Created by Kevin Zhang on 11/16/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "NewMessagePage.h"

@interface NewMessagePage() <UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSMutableArray* reasons;
}

@property(strong,nonatomic)UIPickerView* pickerView;
@end

@implementation NewMessagePage

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (containerView) {
        [containerView removeFromSuperview];
    }
    
    reasons = [[NSMutableArray alloc] initWithObjects:@"Ask a Question", LabelReturnRequest, LabelCancelRequest, @"Other", nil];

    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, [UIView screenWidth], 50)];
    self.pickerView.delegate = self;
    self.pickerView.backgroundColor = [UIColor whiteColor];
    
    self.textFieldReason = [[FullWidthField alloc] initWithPlaceHolder:@"Reason"];
    self.textFieldReason.y = FormTopMargin;
    [self.scrollView addSubview:self.textFieldReason];
    [self.textFieldReason setInputView:self.pickerView];
    self.textFieldReason.inputAccessoryView = nil;
    
    self.textFieldSubject = [[FullWidthField alloc] initWithPlaceHolder:@"Subject"];
    [self.textFieldSubject gray8];
    [self.textFieldSubject belowView:self.textFieldReason withMargin:FieldVMargin];
    [self.scrollView addSubview:self.textFieldSubject];
    self.textFieldSubject.enabled = NO;
    
    self.textFieldContent = [[NSUITextView alloc] initWithFrame:CGRectMake(PagePadding, 100*[UIView scale], FullWidthExcludePadding, 150)];
    self.textFieldContent.placeholder = @"Your message";
    [self.textFieldContent belowView:self.textFieldSubject withMargin:FieldVMargin];
    [self.scrollView addSubview:self.textFieldContent];
    
    self.cameraView = [[UIImageView alloc] initWithFrame:CGRectMake(PagePadding, self.textFieldContent.bottom+PagePadding, 40, 40)];
    self.cameraView.image = [UIImage imageNamed:@"attachment"];
    self.cameraView.contentMode = UIViewContentModeCenter;
    [self.scrollView addSubview:self.cameraView];
    
    self.labelAttachment = [[UILabel alloc] initWithFrame:CGRectMake(self.cameraView.right, self.cameraView.y, 100, 40)];
    self.labelAttachment.text = @"Attach a photo";
    [self.labelAttachment styleTableViewRowTag];
    [self.scrollView addSubview:self.labelAttachment];

    containerView = [self maskViews:[NSArray arrayWithObjects:self.textFieldReason, self.textFieldSubject, self.textFieldContent, nil]];
    [self.scrollView addSubview:containerView];

    return self;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    self.textFieldReason.text = [reasons objectAtIndex:row];
    [self.textFieldReason endEditing:YES];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [reasons count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [reasons objectAtIndex:row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 300;
    
    return sectionWidth;
}

@end
