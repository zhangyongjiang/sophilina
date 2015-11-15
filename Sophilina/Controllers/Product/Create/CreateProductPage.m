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
    
    self.textFieldSubject = [[FullWidthField alloc] initWithPlaceHolder:@"Title"];
    [self.textFieldSubject gray8];
    self.textFieldSubject.y = 100;
    [self.scrollView addSubview:self.textFieldSubject];
//    self.textFieldSubject.enabled = NO;
    
    self.textFieldContent = [[NSUITextView alloc] initWithFrame:CGRectMake(PagePadding, 100*[UIView scale], FullWidthExcludePadding, 150)];
    self.textFieldContent.placeholder = @"Description";
    [self.textFieldContent belowView:self.textFieldSubject withMargin:FieldVMargin];
    [self.scrollView addSubview:self.textFieldContent];
    
    containerView = [self maskViews:[NSArray arrayWithObjects:self.textFieldSubject, self.textFieldContent, nil]];
    [self.scrollView addSubview:containerView];

    return self;
}

@end
