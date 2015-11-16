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
    
    self.textCity = [[FullWidthTextFieldWithLabel alloc] initWithLabel:@"City"];
    [self.scrollView addSubview:self.textCity];
    [self.textCity belowView:self.textFieldContent withMargin:FieldVMargin];
    
    self.textState = [[FullWidthTextFieldWithLabel alloc] initWithLabel:@"State"];
    [self.scrollView addSubview:self.textState];
    [self.textState belowView:self.textCity withMargin:FieldVMargin];
    
    containerView = [self maskViews:[NSArray arrayWithObjects:self.textFieldSubject, self.textFieldContent, self.textCity, self.textState, nil]];
    [self.scrollView addSubview:containerView];

    return self;
}

@end
