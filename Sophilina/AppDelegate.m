//
//  AppDelegate.m
//
//
//  Created by Kevin Zhang on 11/16/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "AppDelegate.h"
#import "NSSlidePanelController.h"
#import "NavigationControllerBase.h"
#import "HomeViewController.h"
#import "WelcomeViewController.h"
#include "MenuViewController.h"
#import "MessageDetailsViewController.h"
#import "TMCache.h"
#import "APBAlertView.h"

@interface AppDelegate ()

@property(strong, nonatomic) NSSlidePanelController* slidePanelController;
@property(strong, nonatomic) NavigationControllerBase* navController;
@property(strong, nonatomic) NSSlidePanelController* resumeController;

@end

@implementation AppDelegate


+(AppDelegate*)getInstance {
    return [UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow* window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.backgroundColor = [UIColor whiteColor];
    [window makeKeyAndVisible];
    self.window = window;
    
    [self setupStyle];
    [self setupCache];
    [self setupNotificationObserver];
    
    NSDictionary* remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if(remoteNotification ) {
        NSLog(@"remote notification %@", remoteNotification);
        NSString* notificationId = [remoteNotification objectForKey:@"id"];
        NSString* data = [remoteNotification objectForKey:@"d"];
        NSString* type = [remoteNotification objectForKey:@"t"];
        
        if ([@"Product" isEqualToString:type]) {
            NSString* productId = data;
//            ProductDetailsViewController* controller = [[ProductDetailsViewController alloc] init];
//            controller.productId = productId;
//            [self startPage:controller];
        }
        else if ([@"Message" isEqualToString:type] && [NSUserDefaults savedUser]) {
            NSString* messageId = data;
//            MessageDetailsViewController* controller = [[MessageDetailsViewController alloc] init];
//            controller.msgId = messageId;
//            [self startPage:controller];
        }
        else {
            [self startPage:[[HomeViewController alloc] init]];
        }
        
        //        NotificationViewController* controller = [[NotificationViewController alloc] init];
        //        controller.notificationId = notificationId;
        //        [self startPage:controller];
    }
    else {
        [self askForNotification];
        
        if ([NSUserDefaults savedUser]) {
            [self startPage:[[HomeViewController alloc] init]];
        }
        else {
            [self startWelcomePage:NO];
        }
    }
    
    [self checkUserLogin];
    [self checkVersions];
    
    return YES;
}

-(void)setupNotificationObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showAlert:) name:NotificationAlert object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLogin:) name:NotificationNoGuest object:nil];
}

-(void)setupCache {
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:0 diskCapacity:100 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
}

-(void)showAlert:(NSNotification*)noti {
    NSString* message = noti.object;
    NSString* title = [noti.userInfo objectForKey:@"title"];
    [self alertWithTitle:title andMsg:message handler:^(UIAlertAction *action) {
    }];
}

-(void)showLogin:(NSNotification*)noti {
    if ([self.navController.topViewController isKindOfClass:[WelcomeViewController class]]) {
        return;
    }
    [WebService removeAllCookies];
    [[TMCache sharedCache] removeAllObjects];
    [NSUserDefaults deleteSavedUser];
    [NSUserDefaults remove:@"LoginPassword"];
    
    if ([UIAlertController class]) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Warning" message:@"The operation you just requested is for login user only. Please click Ok to sign in or sign up." preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self startWelcomePage:YES];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }]];
        [self.navController presentViewController:alert animated:YES completion:nil];
    }
    else {
        APBAlertView *alertView = [[APBAlertView alloc]
                                   initWithTitle:@"Alert"
                                   message:@"The operation you just requested is for login user only. Please click Ok to sign in or sign up."
                                   cancelButtonTitle:@"Cancel"
                                   otherButtonTitles:@[@"Ok"]
                                   cancelHandler:^{
                                   }
                                   confirmationHandler:^(NSInteger otherButtonIndex) {
                                       if (otherButtonIndex == 0) {
                                           [self startWelcomePage:YES];
                                       }
                                   }];
        [alertView show];
    }
}

-(void)askForNotification {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
    
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString* tokenStr = [[NSString alloc] initWithData:deviceToken encoding:NSUTF8StringEncoding];
    const unsigned *tokenBytes = [deviceToken bytes];
    NSString *hexToken = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                          ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                          ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                          ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
    
    NSLog(@"========= Did Register for Remote Notifications with Device Token (%@) %@", hexToken, deviceToken);
    
    [NSUserDefaults savePushNotificationToken:hexToken];
    PushNotificationToken* req = [[PushNotificationToken alloc] init];
    req.token = hexToken;
    [ReuselocalApi PushNotificationAPI_RegisterAppleDeviceToken:req onSuccess:^(GenericResponse *resp) {
        NSLog(@"sent token to server");
    } onError:^(APIError *err) {
        NSLog(@"reg token error %@", err);
    }];
}


- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Did Fail to Register for Remote Notifications");
    NSLog(@"%@, %@", error, error.localizedDescription);
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"didReceiveRemoteNotification %@", userInfo);
    UIApplicationState state = [application applicationState];
    if (state == UIApplicationStateActive) {
        NSString *cancelTitle = @"Close";
        NSString *message = [[userInfo valueForKey:@"aps"] valueForKey:@"alert"];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:cancelTitle
                                                  otherButtonTitles:nil, nil];
        //        [alertView show];
        if ([NSUserDefaults savedUser]) {
            [ReuselocalApi MessageAPI_GetUserMessages:nil size:nil onSuccess:^(MessageDetailsList *resp) {
                [self setBadgeNumber:resp.totalUnread.intValue];
            } onError:^(APIError *err) {
            }];
        }
    } else {
        //        NSString* notificationId = [userInfo objectForKey:@"id"];
        //        NotificationViewController* controller = [[NotificationViewController alloc] init];
        //        controller.notificationId = notificationId;
        //        [self startPage:controller];
        NSString* data = [userInfo objectForKey:@"d"];
        NSString* type = [userInfo objectForKey:@"t"];
        
        if ([@"Message" isEqualToString:type] && [NSUserDefaults savedUser]) {
            NSString* messageId = data;
            MessageDetailsViewController* controller = [[MessageDetailsViewController alloc] init];
            controller.msgId = messageId;
            [self startPage:controller];
        }
        else {
            [self startPage:[[HomeViewController alloc] init]];
        }
    }
}

-(void)startWelcomePage:(BOOL)keepView{
    for (UIViewController* c in self.navController.viewControllers) {
        [[NSNotificationCenter defaultCenter] removeObserver:c];
    }
    
    if (keepView) {
        self.resumeController = self.slidePanelController;
    }
    else {
        self.resumeController = nil;
    }
    
    BOOL animation = self.navController != nil;
    //    animation = NO;
    if (animation) {
        [UIView beginAnimations: @"View Flip" context: nil];
        [UIView setAnimationDuration: 0.6];
        [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition: UIViewAnimationTransitionFlipFromRight forView: self.window cache: NO];
    }
    
    self.navController = [[NavigationControllerBase alloc] init];
    self.window.rootViewController = self.navController;
    [self.navController.navigationBar setBackgroundImage:[UIImage new]
                                           forBarMetrics:UIBarMetricsDefault];
    self.navController.navigationBar.shadowImage = [UIImage new];
    self.navController.navigationBar.translucent = YES;
    
    WelcomeViewController* controller = [[WelcomeViewController alloc] init];
    [self.navController pushViewController:controller animated:YES];
    
    if (animation) {
        [UIView commitAnimations];
    }
}

-(void)resumePage {
    if (!self.resumeController) {
        [self startPage:[[HomeViewController alloc] init]];
        return;
    }
    
    for (UIViewController* c in self.navController.viewControllers) {
        [[NSNotificationCenter defaultCenter] removeObserver:c];
    }
    
    BOOL animation = self.navController != nil;
    //    animation = NO;
    if (animation) {
        [UIView beginAnimations: @"View Flip" context: nil];
        [UIView setAnimationDuration: 0.6];
        [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition: UIViewAnimationTransitionFlipFromLeft forView: self.window cache: NO];
    }
    
    self.window.rootViewController = self.slidePanelController;
    self.navController = (NavigationControllerBase*)self.slidePanelController.centerPanel;
    [self.slidePanelController.centerPanel viewWillAppear:YES];
    [self.slidePanelController.centerPanel viewDidAppear:YES];
    
    [self.navController.topViewController viewWillAppear:YES];
    [self.navController.topViewController viewDidAppear:YES];
    for (UIViewController* c in self.navController.viewControllers) {
        if ([c isKindOfClass:[BaseViewController class]]) {
            BaseViewController* bc = (BaseViewController*)c;
            [bc refreshPage];
        }
    }
    
    if(animation) {
        [UIView commitAnimations];
    }
    
}

-(void) startPage:(UIViewController*)controller {
    [self startPage:controller transition:UIViewAnimationTransitionFlipFromLeft];
}

-(void) startPage:(UIViewController*)controller transition:(UIViewAnimationTransition)transition {
    for (UIViewController* c in self.navController.viewControllers) {
        [[NSNotificationCenter defaultCenter] removeObserver:c];
    }
    
    BOOL animation = self.navController != nil;
    //    animation = NO;
    if (animation) {
        [UIView beginAnimations: @"View Flip" context: nil];
        [UIView setAnimationDuration: 0.6];
        [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition: transition forView: self.window cache: NO];
    }
    
    self.slidePanelController = [[NSSlidePanelController alloc] init];
    self.slidePanelController.shouldDelegateAutorotateToVisiblePanel = false;
    
    self.navController = [[NavigationControllerBase alloc] init];
    self.slidePanelController.centerPanel = self.navController;
    [self.navController pushViewController:controller animated: YES];
    self.navController.navigationBar.translucent = YES;
    
    self.slidePanelController.leftPanel = [[MenuViewController alloc] init];
    NSLog(@"preload leftPanel %@", self.slidePanelController.leftPanel.view);
    
    self.window.rootViewController = self.slidePanelController;
    
    if(animation) {
        [UIView commitAnimations];
    }
}

-(void) showMenu {
    [self.slidePanelController showLeftPanelAnimated:YES];
}

-(void) showViewController:(UIViewController*)controller {
    [self.slidePanelController showCenterPanelAnimated:YES];
    for (UIViewController* c in self.navController.viewControllers) {
        [[NSNotificationCenter defaultCenter] removeObserver:c];
    }
    [self.navController setViewControllers:@[controller]];
}

-(void) pushViewController:(UIViewController*)controller {
    [self.slidePanelController showCenterPanelAnimated:YES];
    [self.navController pushViewController:controller animated:YES];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)checkUserLogin {
    [ReuselocalApi UserAPI_Me:^(User *resp) {
        if (!resp.id) {
            NSString* email = [NSUserDefaults savedEmail];
            NSString* pwd = [NSUserDefaults savedPassword];
            if(email && pwd) {
                LoginRequest* req = [[LoginRequest alloc] init];
                req.email = email;
                req.password = pwd;
                [WebService UserAPI_Login:req onSuccess:^(User *resp) {
                    NSLog(@"auto login succeed");
                } onError:^(APIError *err) {
                    NSLog(@"auto login failed");
                }];
            }
            else {
                [NSUserDefaults deleteSavedUser];
            }
        }
        else {
            [NSUserDefaults saveUser:resp];
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLogout object:nil];
        }
    } onError:^(APIError *err) {
        
    }];
}

-(void)checkVersions {
    return;
    [ReuselocalApi MiscAPI_GetSupportedVersion:^(SupportedVersions *resp) {
        int buildNumber = [[UIApplication build] intValue];
        if (buildNumber<resp.minBuildNumber.intValue || buildNumber>resp.maxBuildNumber.intValue) {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"This version is no longer supported. Please upgrade to latest." preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                NSString *appName = [NSString stringWithString:[[[NSBundle mainBundle] infoDictionary]   objectForKey:@"CFBundleName"]];
                NSURL *appStoreURL = [NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.com/app/%@",[appName stringByReplacingOccurrencesOfString:@" " withString:@""]]];
                [[UIApplication sharedApplication] openURL:appStoreURL];
            }]];
            [self.navController presentViewController:alert animated:YES completion:nil];
        }
        else if(buildNumber<resp.warningBuildNumber.integerValue) {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Warning" message:@"This version will not be supported soon. Please upgrade to latest." preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"Upgrade" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                NSString *appName = [NSString stringWithString:[[[NSBundle mainBundle] infoDictionary]   objectForKey:@"CFBundleName"]];
                NSURL *appStoreURL = [NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.com/app/%@",[appName stringByReplacingOccurrencesOfString:@" " withString:@""]]];
                [[UIApplication sharedApplication] openURL:appStoreURL];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            }]];
            [self.navController presentViewController:alert animated:YES completion:nil];
        }
    } onError:^(APIError *err) {
        
    }];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if([[url host] isEqualToString:@"product"]){
        NSString* productId = [[url path] substringFromIndex:1];
//        ProductDetailsViewController* controller = [[ProductDetailsViewController alloc] init];
//        controller.productId = productId;
//        [self pushViewController:controller];
    }
    return false;
}

-(void)setupStyle {
    [[UINavigationBar appearance]setShadowImage:[[UIImage alloc] init]];
    NSDictionary *barButtonAppearanceDict = @{NSFontAttributeName : [UIFont fontWithName:@"GothamRounded-Light" size:15.0], NSForegroundColorAttributeName: [UIColor colorFromString:@"nsred"]};
    [[UIBarButtonItem appearance] setTitleTextAttributes:barButtonAppearanceDict forState:UIControlStateNormal];
    
        [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"back"]];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"back-active"]];
    
}

-(void)alertWithTitle:(NSString *)title andMsg:(NSString *)msg handler:(void (^)(UIAlertAction *action))handler{
    if ([UIAlertController class])
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:handler]];
        [self.window.rootViewController presentViewController:alert animated:YES completion:^{
        }];
    }
    else
    {
        APBAlertView *alertView = [[APBAlertView alloc]
                                   initWithTitle:title
                                   message:msg
                                   cancelButtonTitle:nil
                                   otherButtonTitles:@[@"OK"]
                                   cancelHandler:^{
                                   }
                                   confirmationHandler:^(NSInteger otherButtonIndex) {
                                       handler(nil);
                                   }];
        [alertView show];
    }
}

-(void)presentViewController:(UIViewController*)controller completion:(void (^)(void))completion{
    [self.navController presentViewController:controller animated:YES completion:completion];
}

-(void)alertWithTitle:(NSString *)title andMsg:(NSString *)msg ok:(void (^)(UIAlertAction *action))ok  cancel:(void (^)(UIAlertAction *action))cancel{
    if ([UIAlertController class]) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:ok]];
        [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:cancel]];
        [self.navController presentViewController:alert animated:YES completion:nil];
    }
    else {
        APBAlertView *alertView = [[APBAlertView alloc]
                                   initWithTitle:title
                                   message:msg
                                   cancelButtonTitle:@"Cancel"
                                   otherButtonTitles:@[@"OK"]
                                   cancelHandler:^{
                                       cancel(nil);
                                   }
                                   confirmationHandler:^(NSInteger otherButtonIndex) {
                                       ok(nil);
                                   }];
        [alertView show];
    }
}

-(void)broadcastEvent:(NSString *)eventName fromSource:(NSObject *)obj data:(NSObject *)data {
    for (BaseViewController* c in self.navController.viewControllers) {
        if ([c respondsToSelector:@selector(handleEvent:fromSource:data:)]) {
            [c handleEvent:eventName fromSource:obj data:data];
        }
    }
    if ([self.window.rootViewController isKindOfClass:[NSSlidePanelController class]]) {
        NSSlidePanelController* root = (NSSlidePanelController*) self.window.rootViewController;
        MenuViewController* menuController = (MenuViewController*)root.leftPanel;
        [menuController handleEvent:eventName fromSource:obj data:data];
    }
}

-(void)setBadgeNumber:(NSInteger)badgeNumber {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:badgeNumber];
    [self broadcastEvent:NotificationMsgChanged fromSource:nil data:[NSNumber numberWithLong:badgeNumber]];
}

-(void)userLoggedIn {
//    MenuViewController* menuController = (MenuViewController*)self.slidePanelController.leftPanel;
//    [menuController userLoggedIn];
}

-(void)userLoggedOut {
//    MenuViewController* menuController = (MenuViewController*)self.slidePanelController.leftPanel;
//    [menuController userLoggedOut];
}
@end
