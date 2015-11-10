//
//  CreateProductPage.m
//
//
//  Created by Kevin Zhang on 11/16/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "CreateProductPage.h"

@interface CreateProductPage() <UIPickerViewDataSource, UIPickerViewDelegate>
{
}

@end

@implementation CreateProductPage

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (containerView) {
        [containerView removeFromSuperview];
    }
    
    self.textFieldSubject = [[FullWidthField alloc] initWithPlaceHolder:@"Subject"];
    [self.textFieldSubject gray8];
    self.textFieldSubject.y = 100;
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

    containerView = [self maskViews:[NSArray arrayWithObjects:self.textFieldSubject, self.textFieldContent, nil]];
    [self.scrollView addSubview:containerView];

    return self;
}

@end
