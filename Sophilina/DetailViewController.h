//
//  DetailViewController.h
//  Sophilina
//
//  Created by Kevin Zhang on 11/5/15.
//  Copyright © 2015 Kevin Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

