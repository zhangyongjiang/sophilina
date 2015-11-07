//
//  SettingsViewController.m
//
//
//  Created by Kevin Zhang on 11/19/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "AboutViewController.h"
#import "Appirater.h"
#import <MessageUI/MessageUI.h>
#import "iToast.h"

@interface AboutViewController () <MFMailComposeViewControllerDelegate>

@end

@implementation AboutViewController

-(void)createPage {
    self.title = @"About";
    CGFloat y = 0;
    if (self.page) {
        [self.page removeFromSuperview];
        UIView* navBar = self.navigationController.navigationBar;
        y = navBar.bottom;
    }
    self.page = [[AboutPage alloc] initWithFrame:self.view.bounds];
    self.page.y = y;
    [self.view addSubview:self.page];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTapFaq:) name:LabelFAQ object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTapRateThisApp:) name:LabelRateThisApp object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTapAboutus:) name:LabelAboutUs object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTapTos:) name:LabelTos object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTapSendFeedback:) name:LabelSendFeedback object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTapPrivacyPolicy:) name:LabelPrivacy object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTapVersion:) name:LabelVersion object:nil];
}

-(void)didTapAboutus:(NSNotification *) notification {
    [self handleNoti:notification toUrl:@"about-us/index.jsp.oo" withTitle:@"About Us"];
}

-(void)didTapVersion:(NSNotification *) notification {
    static int cnt = 0;
    cnt ++;
    if (cnt>5) {
        cnt = 0;
        [WebService switchServer];
        [[iToast makeText:[NSString stringWithFormat:@"switched to %@", [WebService baseUrl]]] show];
    }
}

-(void)didTapTos:(NSNotification *) notification {
    [self handleNoti:notification toUrl:@"tos/index.jsp.oo" withTitle:@"Terms of Service"];
}

-(void)didTapFaq:(NSNotification *) notification {
    [self handleNoti:notification toUrl:@"faq/index.jsp.oo" withTitle:@"FAQ"];
}

-(void)didTapPrivacyPolicy:(NSNotification *) notification {
    [self handleNoti:notification toUrl:@"privacy-policy/index.jsp.oo" withTitle:@"Privacy Policy"];
}

-(void)handleNoti:(NSNotification *) notification toUrl:(NSString*)url withTitle:(NSString*)title {
    if (notification.object != self.page) {
        return;
    }
    
    WebViewController* controller = [[WebViewController alloc] initWithUrl:url andTitle:title];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)didTapRateThisApp:(NSNotification *) notification {
    if (notification.object != self.page) {
        return;
    }

    [Appirater setAppId:@"963231875"];
    [Appirater rateApp];
}

-(void)didTapSendFeedback:(NSNotification *) notification {
    User* me = [NSUserDefaults savedUser];
    if (!me || !me.id) {
        [self sendEmailTo:@"support@nextshopper.com" withSubject:@"Feedback" body:@""];
    }
    else {
//        ContactNextShopperViewController* controller = [[ContactNextShopperViewController alloc] init];
//        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (void) sendEmailTo:(NSString*)to withSubject:(NSString*)subject body:(NSString*)body {
    if( [MFMailComposeViewController canSendMail] )
    {
        MFMailComposeViewController* mailController = [[MFMailComposeViewController alloc] init];
        [mailController setSubject:subject];
        [mailController setMessageBody:body isHTML:NO];
        if( to.length )
            [mailController setToRecipients:[NSArray arrayWithObject:to]];
        
        mailController.mailComposeDelegate = self;
        mailController.navigationBar.tintColor = [UIColor colorFromString:@"nsred"];
        
        [self presentViewController:mailController animated:YES completion:^{
//            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        }];
    }
    else
    {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Email is not configured. Please check your settings and try again."
                                                            message:nil
                                                           delegate:self cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        alertView.tag = -1;
        [alertView show];
    }
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
