//
//  ViewController.m
//  audio
//
//  Created by KudoCC on 15/9/21.
//  Copyright (c) 2015年 KudoCC. All rights reserved.
//

#import "ViewController.h"
#import "AudioRecordViewController.h"
#import "AudioPlaybackViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *arrayTitles;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGSize size = self.view.bounds.size;
    size.height = [UIScreen mainScreen].bounds.size.height;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, size.width, size.height) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    
    _arrayTitles = @[@"Record", @"Playback"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_arrayTitles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.separatorInset = UIEdgeInsetsZero;
        if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
            [cell setPreservesSuperviewLayoutMargins:NO];
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    cell.textLabel.text = _arrayTitles[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        AudioRecordViewController *vc1 = [[AudioRecordViewController alloc] init];
        [self.navigationController pushViewController:vc1 animated:YES];
    } else if (indexPath.row == 1) {
        AudioPlaybackViewController *vc2 = [[AudioPlaybackViewController alloc] init];
        [self.navigationController pushViewController:vc2 animated:YES];
    }
}

@end
