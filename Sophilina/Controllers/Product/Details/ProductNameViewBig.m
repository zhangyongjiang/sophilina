//
//  ProductNameViewBig.m
//
//
//  Created by Kevin Zhang on 1/1/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "ProductNameViewBig.h"

@implementation ProductNameViewBig

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    
    self.numberOfLines = 2;
    self.lineBreakMode = NSLineBreakByWordWrapping;
    [self styleTableViewRowLabel];
    self.textAlignment = NSTextAlignmentCenter;
    self.paddingLeft = PagePadding;

    return self;
}

@end
