//
//  MenuPage.m
//
//
//  Created by Kevin Zhang on 11/22/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "MenuPage.h"
#import "UIImage+ImageEffects.h"

@implementation GuestMenuPage

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    self.tableData = [[SimpleTableViewData alloc] initWithSections:
                      [[SimpleTableViewSection alloc] initWithHeader:nil
                                                             andRows:
                       @"Give Free"
                       , @"Login"
                       , @"About Sophilina"
                       , nil],
                      nil]
    ;
    return self;
}

@end

@implementation UserMenuPage

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    self.tableData = [[SimpleTableViewData alloc] initWithSections:
                      [[SimpleTableViewSection alloc] initWithHeader:nil
                                                             andRows:
                       @"Give Free"
                       , @"My Offers"
                       , @"My Watches"
                       , @"Profile"
                       , @"Change Password"
                       , @"Logout"
                       , @"About Sophilina"
                       , nil],
                      nil]
    ;
    return self;
}

@end

