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
@property(strong, nonatomic)FullWidthField* textField;

@end

@implementation ListPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textField = [[FullWidthField alloc] initWithPlaceHolder:@""];
    [self.view addSubview:self.textField];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.y = self.textField.bottom + PagePadding;
    self.tableView.height = self.tableView.height - self.tableView.y;
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.filtedValues count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ListPickerCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ListPickerCell"];
    }
    cell.textLabel.text = [self.values objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    self.onChange(cell.textLabel.text);
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)setValues:(NSMutableArray *)values {
    _values = values;
    self.filtedValues = [NSMutableArray arrayWithArray:values];
}
@end
