//
//  Page.m
//
//
//  Created by Kevin Zhang on 11/16/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "Page.h"
#import "FLAnimatedImage.h"

@interface Page()
{
    UIView* _emptyView;
}
@end

@implementation Page

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor colorFromString:@"nsbg"];
    
    return self;
}

-(void)setEmptyPageText:(NSString *)text {
    UILabel* label = [[UILabel alloc] initWithFrame:self.bounds];
    label.width = label.width * 0.68;
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.text = text;
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];
    [self setEmptyPageView:label];
}

-(void)setEmptyPageView:(UIView *)view {
    if(_emptyView)
        [_emptyView removeFromSuperview];
    _emptyView = view;
    [self addSubview:_emptyView];
    [_emptyView centerInParent];
}

-(void)reload {
}

-(void)beginRefresh {
}

-(void)endRefresh {
}

-(void)show:(NSString*)name width:(CGFloat)imgw height:(CGFloat)imgh x:(CGFloat)x y:(CGFloat)y toView:(UIView*)view {
    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:@"gif"]]];
    FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
    imageView.animatedImage = image;
    CGFloat scalex = [UIView screenWidth] / imgw;
    CGFloat scaley = [UIView screenHeight] / imgh;
    CGFloat width = [UIView screenWidth];
    CGFloat height = [UIView screenHeight];
    if (scalex > scaley) {
        height = imgh * scalex;
    }
    else {
        width = imgw * scaley;
    }
    imageView.frame = CGRectMake(x, y, width, [UIView screenHeight]);
    [view addSubview:imageView];
    
    UIView* cover = [[UIView alloc] initWithFrame:self.frame];
    cover.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    [view addSubview:cover];
    
    [view sendSubviewToBack:cover];
    [view sendSubviewToBack:imageView];
}

-(NSButton*)createActionButton:(NSString*)title image:(NSString*)imgname bgcolr:(UIColor*)color{
    NSButton* btn = [[NSButton alloc] initWithFrame:CGRectMake(PagePadding, 0, 250, 45)];
    [btn styleBook17];
    [self addSubview:btn];
    [btn alignParentRightWithMarghin:10*[UIView scale]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor mainColor] forState:UIControlStateSelected];
//    [btn setTitleColor:[UIColor mainColor] forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateSelected];
    [btn setTitle:title forState:UIControlStateHighlighted];
    
    UIImage* img = [UIImage imageNamed:imgname];
    [btn setImage:img forState:UIControlStateNormal];
    [btn setImage:img forState:UIControlStateSelected];
    [btn setImage:img forState:UIControlStateHighlighted];
    [btn hcenterInParent];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
    
//    [btn setBackgroundImage:[self imageWithColor:color] forState:UIControlStateNormal];
    btn.backgroundColor = color;
    
    btn.layer.borderColor = [UIColor whiteColor].CGColor;
    btn.layer.borderWidth = 1;
    btn.layer.masksToBounds = YES;

    UIImage* bgimg = [self imageWithColor:[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.5] ];
    [btn setBackgroundImage:bgimg forState:UIControlStateSelected];
    [btn setBackgroundImage:bgimg forState:UIControlStateHighlighted];
    
    return btn;
}

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

@end


