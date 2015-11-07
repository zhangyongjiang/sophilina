//
//  AppDelegate.h
//
//
//  Created by Kevin Zhang on 11/16/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property(strong, nonatomic) UIWindow *window;
@property(assign,nonatomic)BOOL autoPlay;
@property(assign,nonatomic)int autoPlayDelay;

+(AppDelegate*)getInstance;

- (void) startWelcomePage:(BOOL)keepView;
- (void) startPage:(UIViewController*)controller ;
-(void) startPage:(UIViewController*)controller transition:(UIViewAnimationTransition)transition ;
- (void) resumePage;
- (void) showMenu;
- (void) showViewController:(UIViewController*)controller;
- (void) pushViewController:(UIViewController*)controller ;
- (void) presentViewController:(UIViewController*)controller completion:(void (^)(void))completion;
- (void) alertWithTitle:(NSString *)title andMsg:(NSString *)msg handler:(void (^)(UIAlertAction *action))handler;
- (void) alertWithTitle:(NSString *)title andMsg:(NSString *)msg ok:(void (^)(UIAlertAction *action))ok  cancel:(void (^)(UIAlertAction *action))cancel;
-(void)showLogin:(NSNotification*)noti ;
-(void)broadcastEvent:(NSString *)eventName fromSource:(NSObject *)obj data:(NSObject *)data;
-(void)setBadgeNumber:(NSInteger)badgeNumber;

-(void)userLoggedIn;
-(void)userLoggedOut;
@end

extern NSString* gLanguage;

