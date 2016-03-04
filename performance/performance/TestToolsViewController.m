//
//  TestToolsViewController.m
//  performance
//
//  Created by KudoCC on 16/1/21.
//  Copyright © 2016年 KudoCC. All rights reserved.
//

#import "TestToolsViewController.h"
#import "CornerRadiusView.h"
#import "CornerRadiusView+WebCache.h"
#import "TestView.h"

@interface TestToolsCell : UITableViewCell

@property (nonatomic, strong) CornerRadiusView *imgView1;
@property (nonatomic, strong) CornerRadiusView *imgView2;
@property (nonatomic, strong) CornerRadiusView *imgView3;

@end

@implementation TestToolsCell

- (CornerRadiusView *)createImageView:(UIViewContentMode)mode {
    CornerRadiusView *v = [[CornerRadiusView alloc] initWithFrame:CGRectZero];
    v.backgroundColor = [UIColor clearColor];
    v.image = [UIImage imageNamed:@"big"];
    v.borderWidth = 5.0;
    v.borderColor = [UIColor redColor];
    v.contentMode = mode;
    v.cornerRadius = 5.0;
    return v;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        static NSInteger type = 0;
        _imgView1 = [self createImageView:(type++)%(UIViewContentModeBottomRight+1)];
        [self.contentView addSubview:_imgView1];
        
        _imgView2 = [self createImageView:(type++)%(UIViewContentModeBottomRight+1)];
        [self.contentView addSubview:_imgView2];
        
        _imgView3 = [self createImageView:(type++)%(UIViewContentModeBottomRight+1)];
        [self.contentView addSubview:_imgView3];
        
        self.contentView.backgroundColor = [UIColor greenColor];
    }
    return self;
}

- (void)layoutSubviews {
    CGFloat y = 2.0;
    CGSize s = CGSizeMake(self.bounds.size.height-4.0, self.bounds.size.height-4.0);
    _imgView1.frame = CGRectMake(0.0, y, s.height, s.height);
    _imgView2.frame = CGRectMake(s.height + 10.0, y, s.height, s.height);
    _imgView3.frame = CGRectMake(s.height + 10.0 + s.height + 10.0, y, s.height, s.height);
}

@end

@interface TestToolsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIImage *image;

@end

@implementation TestToolsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor brownColor];
    
    TestView *v = [[TestView alloc] initWithFrame:CGRectMake(0.0, 64.0, 100.0, 100.0)];
    v.backgroundColor = [UIColor redColor];
    [self.view addSubview:v];
    
    _image = [UIImage imageNamed:@"big"];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:tableView];
    tableView.backgroundView = v;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.separatorInset = UIEdgeInsetsZero;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 96.0;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TestToolsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (!cell) {
        cell = [[TestToolsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
        cell.separatorInset = UIEdgeInsetsZero;
        if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
            [cell setPreservesSuperviewLayoutMargins:NO];
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
    }
//    cell.imgView1.image = [UIImage imageNamed:@"big"];
//    cell.imgView2.image = [UIImage imageNamed:@"big"];
//    cell.imgView3.image = [UIImage imageNamed:@"big"];
    
    cell.imgView1.image = _image;
    cell.imgView2.image = _image;
    cell.imgView3.image = _image;
//    NSLog(@"%@, %@, %@", cell.imgView1.image, cell.imgView2.image, cell.imgView3.image);
    [cell.imgView1 sd_setImageWithURL:[NSURL URLWithString:@"http://i2.sinaimg.cn/gm/2015/0710/U5732P115DT20150710120957.jpg"]];
    
    return cell;
}

@end
