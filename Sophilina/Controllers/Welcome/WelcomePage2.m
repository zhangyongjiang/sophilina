//
//  WelcomePage.m
//
//
//  Created by Kevin Zhang on 11/16/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "WelcomePage2.h"
#import "UIImage+ImageEffects.h"

@implementation WelcomePage2

- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (YES) {
        [self setBackgroundImage:@"welcome"];
//        [self show:@"animated2-615x346" width:615 height:346 x:-450 y:0 toView:self];
    }
    else {
        UIImage* img = [UIImage imageNamed:@"welcome"];
        img = [img scaleToSize:self.frame.size];
        img = [img applyBlurWithRadius:6 tintColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0.2] saturationDeltaFactor:1.8 maskImage:nil];
        self.backgroundColor = [UIColor colorWithPatternImage:img];
    }
    
    {
        CGRect frame = CGRectMake(0, 0, 225, 75);
        self.logoView = [[LogoImageView alloc] initWithScaledFrame:frame];
        [self addSubview:self.logoView];
        [self.logoView hcenterInParent];
        [self.logoView alignParentTopWithMarghin:88*[UIView scale]];
    }
    
    {
        self.signinBtn = [self createActionButton:@"Sign In With Email" image:@"signin" bgcolr:[UIColor clearColor]];
        self.signinBtn.accessibilityLabel = @"signinBtn";
        [self.signinBtn alignParentBottomWithMarghin:108*[UIView scale]];
        
        self.signupBtn = [self createActionButton:@"Create New Account" image:@"signup" bgcolr:[UIColor clearColor]];
        self.signupBtn.layer.borderWidth = 0;
        self.signupBtn.accessibilityLabel = @"signupBtn";
        UIImage* fgimg = [self imageWithColor:[UIColor mainColor] ];
        UIImage* bgimg = [self imageWithColor:[UIColor colorWithRed:224/255. green:24/255. blue:50/255. alpha:1] ];
        [self.signupBtn setBackgroundImage:fgimg forState:UIControlStateNormal];
        [self.signupBtn setBackgroundImage:bgimg forState:UIControlStateSelected];
        [self.signupBtn setBackgroundImage:bgimg forState:UIControlStateHighlighted];
        [self.signupBtn alignParentBottomWithMarghin:175*[UIView scale]];
    }
    
    {
        self.skipForNowLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
        [self.skipForNowLabel styleMenuItem];
        [self.skipForNowLabel setTextColor:[UIColor whiteColor]];
        self.skipForNowLabel.text = @"Skip for now";
        self.skipForNowLabel.accessibilityLabel = @"Skip for now";
        [self addSubview:self.skipForNowLabel];
        [self.skipForNowLabel belowView:self.signinBtn withMargin:32*[UIView scale]];
        self.skipForNowLabel.right = self.signinBtn.right;
    }
    return self;
}

@end
