//
//  NavigationControllerBase.m
//  Next Shopper
//
//  Created by Kevin Zhang on 10/12/14.
//  Copyright (c) 2014 Gaoshin. All rights reserved.
//

#import "NavigationControllerBase.h"
#import "CoverView.h"
#import "FLAnimatedImage.h"
#import "UIImage+ImageEffects.h"
#import "AppConfiguration.h"

@interface NavigationControllerBase() <UIGestureRecognizerDelegate>

@property(strong, nonatomic)CoverView* cover;

@end

@interface NavigationControllerBase ()

@end

@implementation NavigationControllerBase

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.tintColor = [UIColor mainColor];
    self.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                              [UIFont fontWithName:FontMedium size:17.0],
                                              NSFontAttributeName,
                                              nil];
    self.cover = [[CoverView alloc] initWithFrame:self.view.bounds];
    self.cover.hidden = YES;
    self.cover.alpha = 0;
    [self.view addSubview:self.cover];
    [self.view bringSubviewToFront:self.cover];
    
    [self addGoHomeButton];
//    [self addAutoTestButton];
}

-(void)addGoHomeButton {
    CGFloat width = 40;
    UIView* testView = [[UIView alloc] initWithFrame:CGRectMake(([UIView screenWidth]-width)/2, 0, width, 64)];
    [self.view addSubview:testView];
    testView.backgroundColor  = [UIColor clearColor];
    [testView addTarget:self action:@selector(goHome:)];
    
//    UIImageView* imgView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIView screenWidth]-width)/2, 20, width, 44)];
//    imgView.image = [UIImage imageNamed:@"menu"];
//    [self.view addSubview:imgView];
//    imgView.backgroundColor  = [UIColor clearColor];
//    [imgView addTarget:self action:@selector(goHome:)];
}

-(void)addAutoTestButton {
    UIView* testView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.view addSubview:testView];
    [testView alignParentBottomWithMarghin:0];
    [self.view bringSubviewToFront:testView];
    testView.backgroundColor  = [UIColor clearColor];
    [testView addTarget:self action:@selector(handleLongPress)];
}

-(void)handleLongPress {
}

-(void) goHome:(id)sender {
//    [[AppDelegate getInstance] startPage:[[HomeViewController alloc] init] ];
    [[AppDelegate getInstance] showMenu];
}

-(void)setEnabled:(BOOL)enabled
{
    if (enabled == self.cover.hidden) {
        return;
    }
    if(!enabled) {
        self.cover.hidden = NO;
        __block UIImage* image = [self.view toImage];
        UIColor *tintColor = [UIColor colorWithWhite:0.32 alpha:0.73];
        image = [image applyBlurWithRadius:10 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];

        [UIView animateWithDuration:0.5f animations:^{
            self.cover.backgroundColor = [UIColor colorWithPatternImage:image];
            self.cover.alpha = 1;
        } completion:^(BOOL finished) {
        }];
    }
    else {
        [UIView animateWithDuration:0.5f animations:^{
            self.cover.alpha = 0;
        } completion:^(BOOL finished) {
            self.cover.hidden = YES;
        }];
    }
}

-(void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}

-(void)autoNext:(NSObject*)obj {
    BaseViewController* bc = (BaseViewController*)obj;
    [bc handleEvent:@"Auto" fromSource:self data:nil];
}

-(void)setViewControllers:(NSArray *)viewControllers {
    [super setViewControllers:viewControllers];
    [self checkTutorialForController:self.topViewController];
}

-(void)checkTutorialForController:(UIViewController *)viewController {
    NSString* key = [NSString stringWithFormat:@"%@.tutorial", [viewController class]];
    NSString* tutorial = [[AppConfiguration getInstance] getConf:key];
    if (tutorial == nil) {
        return;
    }
    
    NSString* viewed = [NSUserDefaults get:key];
    if(viewed != nil && [viewed isEqualToString:tutorial]) {
        return;
    }
    [NSUserDefaults save:tutorial forKey:key];
    
    if ([tutorial hasPrefix:@"img:"]) {
        NSString* img = [tutorial substringFromIndex:4];
        UIImageView* view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIView screenWidth], [UIView screenHeight])];
        view.contentMode = UIViewContentModeScaleToFill;
        view.image = [UIImage imageNamed:img];
        [self.view addSubview:view];
        [self.view bringSubviewToFront:view];
        [view addTarget:self action:@selector(tutorialClicked:)];
    }
    else if([tutorial hasPrefix:@"animated:"]) {
        NSString* img = [tutorial substringFromIndex:9];
        NSString* durationKey = [NSString stringWithFormat:@"%@.duration", key];
        int duration = [[AppConfiguration getInstance] getConfAsInt:durationKey defaultValue:3];
        UIImageView* view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIView screenWidth], [UIView screenHeight])];
        view.contentMode = UIViewContentModeScaleToFill;
        view.image = [UIImage animatedImageNamed:img duration:duration];
        [self.view addSubview:view];
        [self.view bringSubviewToFront:view];
        [view addTarget:self action:@selector(tutorialClicked:)];
    }
    else if([tutorial hasPrefix:@"animated-gif:"]) {
        NSString* img = [tutorial substringFromIndex:13];
        FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataFromFile:img andExt:@"gif"]];
        FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
        imageView.animatedImage = image;
        imageView.frame = CGRectMake(0.0, 0.0, [UIView screenWidth], [UIView screenHeight]);
        [self.view addSubview:imageView];
        [self.view bringSubviewToFront:imageView];
        [imageView addTarget:self action:@selector(tutorialClicked:)];
    }
}

-(void)tutorialClicked:(UITapGestureRecognizer*)sender {
    [sender.view removeFromSuperview];
}

-(UIViewController*)popViewControllerAnimated:(BOOL)animated {
    UIViewController* controller = [super popViewControllerAnimated:animated];
    if ([controller isKindOfClass:[BaseViewController class]]) {
        BaseViewController* bc = (BaseViewController *) controller;
        [bc cancelAllOperations];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:controller];
    return controller;
}

@end
