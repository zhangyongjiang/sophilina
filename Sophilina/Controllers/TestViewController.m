//
//  TestViewController.m
//  Quber
//
//  Created by Kevin Zhang on 8/24/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(200, 200, 100, 150)];
    [btn addTarget:self action:@selector(openRaved)];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"Rave!" forState:UIControlStateNormal];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:btn];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)openRaved {
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
