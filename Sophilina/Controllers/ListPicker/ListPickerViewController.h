//
//  ListPickerViewController.h
//  Sophilina
//
//  Created by Kevin Zhang on 11/16/15.
//  Copyright © 2015 Kevin Zhang. All rights reserved.
//

#import "BaseViewController.h"

@interface ListPickerViewController : BaseViewController

@property(strong,nonatomic)NSMutableArray* values;
@property(strong,nonatomic)NSMutableArray* filtedValues;

@property (nonatomic, copy)void (^onChange)(NSString *selectedValue);

@end
