//
//  ViewController.m
//  ImageMask
//
//  Created by KudoCC on 16/1/7.
//  Copyright © 2016年 KudoCC. All rights reserved.
//

#import "ViewController.h"
#import "UIViewMaskImageWithImageMask.h"
#import "UIViewMaskImageWithImage.h"
#import "UIViewMaskImageWithColor.h"
#import "UIViewMaskImageByClippingContext.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
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
    return 44.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = [[UIViewController alloc] init];
    UIView *v = nil;
    switch (indexPath.row) {
        case 0:
            v = [[UIViewMaskImageWithImageMask alloc] initWithFrame:[UIScreen mainScreen].bounds];
            break;
        case 1:
            v = [[UIViewMaskImageWithImage alloc] initWithFrame:[UIScreen mainScreen].bounds];
            break;
        case 2:
            v = [[UIViewMaskImageWithColor alloc] initWithFrame:[UIScreen mainScreen].bounds];
            break;
        case 3:
            v = [[UIViewMaskImageByClippingContext alloc] initWithFrame:[UIScreen mainScreen].bounds];
            break;
        default:
            break;
    }
    vc.view.backgroundColor = [UIColor whiteColor];
    if (v) {
        [vc.view addSubview:v];
    }
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
    }
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"UIViewMaskImageWithImageMask";
            break;
        case 1:
            cell.textLabel.text = @"UIViewMaskImageWithImage";
            break;
        case 2:
            cell.textLabel.text = @"UIViewMaskImageWithColor";
            break;
        case 3:
            cell.textLabel.text = @"UIViewMaskImageByClippingContext";
            break;
        default:
            break;
    }
    return cell;
}

@end
