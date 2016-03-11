//
//  ViewController.m
//  URLSessionTest
//
//  Created by KudoCC on 16/3/4.
//  Copyright © 2016年 KudoCC. All rights reserved.
//

#import "ViewController.h"
#import "DataTaskBasicAuthViewController.h"
#import "DataTaskHttpsServerAuthViewController.h"
#import "UIDownloadTaskViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *arrayTitle;
@property (nonatomic, strong) NSArray *arrayClass;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _arrayTitle = @[@"Basic Authentication", @"HTTPS", @"Test download task"];
    _arrayClass = @[[DataTaskBasicAuthViewController class],
                    [DataTaskHttpsServerAuthViewController class],
                    [UIDownloadTaskViewController class]];
    
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
