//
//  ViewController.m
//  ZoomableScrollView
//
//  Created by SPM on 13/01/2014.
//  Copyright (c) 2014 . All rights reserved.
//

#import "ImageViewController.h"
#import "SVProgressHUD.h"

@interface ImageViewController ()
@property (strong, nonatomic) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.scrollView];
    self.view.backgroundColor = [UIColor colorFromRGB:0x303030];
    self.scrollView.backgroundColor = [UIColor clearColor];
    
    self.imageView = [[UIImageView alloc] init];
    if (self.imagePath) {
        [SVProgressHUD show];
        __weak ImageViewController* controller = self;
        [self.imageView setImageWithPath:self.imagePath placeholderImage:nil success:^(UIImage *image, UIImageView *view) {
            [SVProgressHUD popActivity];
            if (image) {
                controller.image = image;
                [controller addImage];
            }
        }];
    }
    else {
        [self addImage];
    }
    
    self.scrollView.delegate=self;
    self.scrollView.minimumZoomScale = 1.0;
    self.scrollView.maximumZoomScale = 10.0;
    
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 100, 40)];
    btn.backgroundColor = [UIColor colorFromRGB:0xa0a0a0];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"Cancel" forState:UIControlStateNormal];
    btn.layer.borderColor = [UIColor blackColor].CGColor;
    btn.layer.borderWidth = 0.5;
    btn.layer.cornerRadius = btn.height / 2.;
    [btn addTarget:self action:@selector(cancelPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

-(void)addImage {
    CGFloat scale = self.image.size.width / self.image.size.height;
    self.imageView.image = self.image;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.y = 64;
    self.imageView.width = [UIView screenWidth];
    self.imageView.height = [UIView screenWidth] / scale;
    [self.scrollView addSubview:self.imageView];
}

-(void)cancelPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - UIScrollViewDelegate methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

-(BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.scrollView.zoomScale == self.scrollView.minimumZoomScale) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - Private methods

- (IBAction)handleSingleTap:(UIButton *)tapGestureRecognizer {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
