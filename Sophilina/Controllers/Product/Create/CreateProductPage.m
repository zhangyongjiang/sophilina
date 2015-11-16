//
//  CreateProductPage.m
//
//
//  Created by Kevin Zhang on 11/16/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "CreateProductPage.h"
#import "ListValuePickerView.h"
#import "UnitedStatesCities.h"
#import "ListPickerViewController.h"

@interface CreateProductPage() <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>
@end


@implementation CreateProductPage

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (containerView) {
        [containerView removeFromSuperview];
    }
    
    self.textState = [[FullWidthTextFieldWithLabel alloc] initWithLabel:@"State"];
    [self.scrollView addSubview:self.textState];
    [self.textState belowView:self.textFieldContent withMargin:FieldVMargin];
    self.textState.textField.delegate = self;
    self.textState.textField.text = @"CA";
    
    self.textCity = [[FullWidthTextFieldWithLabel alloc] initWithLabel:@"City"];
    [self.scrollView addSubview:self.textCity];
    [self.textCity belowView:self.textState withMargin:FieldVMargin];
    self.textCity.textField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    self.textCity.textField.delegate = self;
    
    containerView = [self maskViews:[NSArray arrayWithObjects:self.textFieldSubject, self.textFieldContent, self.textState, self.textCity, nil]];
    [self.scrollView addSubview:containerView];

    return self;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.textState.textField) {
        ListPickerViewController* c = [[ListPickerViewController alloc] init];
        c.values = [UnitedStatesCities getStates];
        c.onChange = ^(NSString* selected) {
            self.textState.textField.text = selected;
        };
        [[AppDelegate getInstance] presentViewController:c completion:^{
        }];
    }
    else if (textField == self.textCity.textField) {
        ListPickerViewController* c = [[ListPickerViewController alloc] init];
        c.values = [UnitedStatesCities getCities:self.textState.text];
        c.onChange = ^(NSString* selected) {
            self.textState.textField.text = selected;
        };
        [[AppDelegate getInstance] presentViewController:c completion:^{
        }];
    }
}
@end
