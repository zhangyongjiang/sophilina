//
//  ListPickerViewController.m
//  Sophilina
//
//  Created by Kevin Zhang on 11/16/15.
//  Copyright © 2015 Kevin Zhang. All rights reserved.
//

#import "ListPickerViewController.h"

@interface ListPickerViewController () <UITableViewDataSource, UITableViewDelegate>

@property(strong, nonatomic)UITableView* tableView;

@end

@implementation ListPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.values count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ListPickerCell"];
    cell.textLabel.text = [self.values objectAtIndex:indexPath.row];
    return cell;
}
@end
