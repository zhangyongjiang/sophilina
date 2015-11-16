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
@property(strong,nonatomic)ListValuePickerView* statePickerView;
@property(strong,nonatomic)ListValuePickerView* cityPickerView;
@end


@implementation CreateProductPage

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (containerView) {
        [containerView removeFromSuperview];
    }
    
    self.statePickerView = [[ListValuePickerView alloc] initWithFrame:CGRectMake(0, 0, [UIView screenWidth], 150)];
    self.statePickerView.values = [UnitedStatesCities getStates];
    self.statePickerView.delegate = self;
    self.statePickerView.dataSource = self;
    self.statePickerView.backgroundColor = [UIColor whiteColor];
    
    self.cityPickerView = [[ListValuePickerView alloc] initWithFrame:CGRectMake(0, 0, [UIView screenWidth], 150)];
    self.cityPickerView.values = [UnitedStatesCities getCities:@"CA"];
    self.cityPickerView.delegate = self;
    self.cityPickerView.dataSource = self;
    self.cityPickerView.backgroundColor = [UIColor whiteColor];

    self.textState = [[FullWidthTextFieldWithLabel alloc] initWithLabel:@"State"];
    [self.scrollView addSubview:self.textState];
    [self.textState belowView:self.textFieldContent withMargin:FieldVMargin];
    self.textState.textField.inputView = self.statePickerView;
    
    self.textCity = [[FullWidthTextFieldWithLabel alloc] initWithLabel:@"City"];
    [self.scrollView addSubview:self.textCity];
    [self.textCity belowView:self.textState withMargin:FieldVMargin];
    self.textCity.textField.inputView = self.cityPickerView;
    self.textCity.textField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    self.textCity.textField.delegate = self;
    
    containerView = [self maskViews:[NSArray arrayWithObjects:self.textFieldSubject, self.textFieldContent, self.textState, self.textCity, nil]];
    [self.scrollView addSubview:containerView];

    return self;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    if (pickerView == self.statePickerView) {
        NSString* country = [self.statePickerView.values objectAtIndex:row];
        self.textState.text = country;
        [self.textState.textField endEditing:YES];
        
        self.textCity.text = @"";
        self.cityPickerView.values = [UnitedStatesCities getCities:country];
        [self.cityPickerView reloadAllComponents];
    }
    else if(pickerView == self.cityPickerView) {
        self.textCity.text = [self.cityPickerView.values objectAtIndex:row];
        [self.textCity.textField endEditing:YES];
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    ListValuePickerView* view = (ListValuePickerView*)pickerView;
    return view.values.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    ListValuePickerView* view = (ListValuePickerView*)pickerView;
    NSString* str = [view.values objectAtIndex:row];
    return str;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 300;
    return sectionWidth;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField==self.textCity.textField) {
        self.textCity.textField.text = [textField.text stringByReplacingCharactersInRange:range withString:[string uppercaseString]];
        return NO;
    }
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.textState.textField) {
        
    }
}
@end
