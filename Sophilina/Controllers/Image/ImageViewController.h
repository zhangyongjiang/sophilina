//
//  ViewController.h
//  ZoomableScrollView
//
//  Created by SPM on 13/01/2014.
//  Copyright (c) 2014 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : BaseViewController <UIScrollViewDelegate>

@property(strong,nonatomic)UIImage* image;
@property(strong,nonatomic)NSString* imagePath;

@end
