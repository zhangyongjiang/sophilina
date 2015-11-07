//
//  SettingsPage.m
//
//
//  Created by Kevin Zhang on 11/19/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "AboutPage.h"

@implementation AboutPage

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.tableData = [[SimpleTableViewData alloc] initWithSections:
                      [[SimpleTableViewSection alloc] initWithHeader:@"nextshopper" andRows:LabelAboutUs, LabelFAQ, LabelSendFeedback, LabelTos, LabelPrivacy, nil],
                      [[SimpleTableViewSection alloc] initWithHeader:@"" andRows:LabelRateThisApp, LabelVersion, nil],
                      nil] ;
    return self;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    if ([cell.textLabel.text isEqualToString:LabelVersion]) {
        NSString* version = [NSString stringWithFormat:@"%@ / %@", [UIApplication appVersion], [UIApplication build]];
        [cell addRightText:version];
    }
    else {
        cell.accessoryView = nil;
    }
    return cell;
}

@end
