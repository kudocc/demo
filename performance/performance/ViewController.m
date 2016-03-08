//
//  ViewController.m
//  performance
//
//  Created by KudoCC on 16/1/19.
//  Copyright © 2016年 KudoCC. All rights reserved.
//

#import "ViewController.h"
#import "TableViewPerformanceViewController.h"
#import "TestMissalignedViewController.h"
#import "TestBlendViewController.h"
#import "TestToolsViewController.h"
#import "TestDrawScaleViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *arrayTitle;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _arrayTitle = @[@"Test clipToMask", @"Test draw scale", @"Test missaligned", @"Test blend", @"Test tools"];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {    
    UIViewController *vc = nil;
    switch (indexPath.row) {
        case 0:
            vc = [[TableViewPerformanceViewController alloc] init];
            break;
        case 1:
            vc = [[TestDrawScaleViewController alloc] init];
            break;
        case 2:
            vc = [[TestBlendViewController alloc] init];
            break;
        case 3:
            vc = [[TestToolsViewController alloc] init];
            break;
        case 4:
            vc = [[TestMissalignedViewController alloc] init];
            break;
        default:
            break;
    }
    vc.title = _arrayTitle[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_arrayTitle count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
    }
    cell.textLabel.text = _arrayTitle[indexPath.row];
    return cell;
}

@end
