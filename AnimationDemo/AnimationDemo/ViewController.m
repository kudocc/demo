//
//  ViewController.m
//  AnimationDemo
//
//  Created by yuanrui on 15/4/27.
//  Copyright (c) 2015年 KudoCC. All rights reserved.
//

#import "ViewController.h"
#import "ImplicityAnimationViewController.h"
#import "CABasicAnimationTestViewController.h"
#import "CAKeyframeViewController.h"
#import "CAActionTestViewController.h"
#import "CAShapeLayerTestViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *arrayTitle;
@property (nonatomic, strong) NSArray *arrayClass;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _arrayTitle = @[@"Implicity Animation", @"CABasicAnimation", @"CAKeyframeAnimation", @"CAAction", @"ShapeLayer Animation"];
    _arrayClass = @[[ImplicityAnimationViewController class],
                    [CABasicAnimationTestViewController class],
                    [CAKeyframeViewController class],
                    [CAActionTestViewController class],
                    [CAShapeLayerTestViewController class]];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:tableView];
    tableView.tableFooterView = [UIView new];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.opaque = YES;
    tableView.delegate = self;
    tableView.dataSource = self;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Class class = _arrayClass[indexPath.row];
    UIViewController *vc = (UIViewController *)[[class alloc] init];
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
