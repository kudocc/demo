//
//  TableViewPerformanceViewController.m
//  performance
//
//  Created by KudoCC on 16/1/19.
//  Copyright © 2016年 KudoCC. All rights reserved.
//

#import "TableViewPerformanceViewController.h"
#import "CornerRadiusView.h"
#import "UIView+CornerRadius.h"

@interface ImageViewPerformanceCell : UITableViewCell

@property (nonatomic, strong) UIView *imgView1;
@property (nonatomic, strong) UIView *imgView2;
@property (nonatomic, strong) UIView *imgView3;

@end

@implementation ImageViewPerformanceCell

+ (CGFloat)cellHeight {
    return 88.0;
}

+ (CGFloat)imageHeight {
    return 66.0;
}

- (UIView *)createImageView {
    
    /**
     
     图片的质量貌似还是UIImageView好一些，CornerRadiusView上的比较模糊，原因未知
     
     */
    
#define Performance 3
    
#if Performance == 1
    /**
     在iPhone4上帧率在20-30左右，与是否设置cornerRadius无关
     在iPhone6上帧率接近60；增加到3个imageView，接近60；
     
     总结下来，CornerRadiusView比较耗cpu，所以在cpu差的机器上表现不好
     */
    CornerRadiusView *v = [[CornerRadiusView alloc] initWithFrame:CGRectMake(0.0, 0.0, [self.class imageHeight], [self.class imageHeight])];
    v.backgroundColor = [UIColor clearColor];
    v.contentMode = UIViewContentModeScaleToFill;
    v.cornerRadius = 10.0;
    v.borderWidth = 1.0;
    v.borderColor = [UIColor blackColor];
#elif Performance == 2
    /**
     在iPhone4上帧率30左右；如果masksToBounds为NO，帧率在50以上。
     在iPhone6上接近60；如果masksToBounds为NO，接近60。表现太好，增加到3个imageView，如果masksToBounds为YES，帧率接近40；masksToBounds为NO，帧率接近60。
     */
    UIImageView *v = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, [self.class imageHeight], [self.class imageHeight])];
    v.layer.cornerRadius = 10.0;
    v.layer.masksToBounds = YES;
    v.layer.borderColor = [UIColor blackColor].CGColor;
    v.layer.borderWidth = 1.0;
#else
    /**
     在图的imageView上覆盖一个圆角的图
     在iPhone4开三个imageView，帧率在50以上，效果杠杠滴
     */
    
    UIImageView *v = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, [self.class imageHeight], [self.class imageHeight])];
    [v cornerRadius_addCornerRadius:10.0 backgroundColor:[UIColor whiteColor]];
#endif
    
    
    return v;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _imgView1 = [self createImageView];
        [self.contentView addSubview:_imgView1];
        
        _imgView2 = [self createImageView];
        [self.contentView addSubview:_imgView2];
        
        _imgView3 = [self createImageView];
        [self.contentView addSubview:_imgView3];
    }
    return self;
}

- (void)layoutSubviews {
    CGSize s = self.bounds.size;
    _imgView1.frame = CGRectMake(0.0, 10.0, _imgView1.bounds.size.height, _imgView1.bounds.size.height);
    _imgView2.frame = CGRectMake(s.height + 10.0, 10.0, _imgView2.bounds.size.height, _imgView2.bounds.size.height);
    _imgView3.frame = CGRectMake(s.height + 10.0 + s.height + 10.0, 10.0, _imgView3.bounds.size.height, _imgView3.bounds.size.height);
}

@end

@interface TableViewPerformanceViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation TableViewPerformanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor brownColor];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:tableView];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.separatorInset = UIEdgeInsetsZero;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ImageViewPerformanceCell cellHeight];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ImageViewPerformanceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (!cell) {
        cell = [[ImageViewPerformanceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
        cell.separatorInset = UIEdgeInsetsZero;
        if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
            [cell setPreservesSuperviewLayoutMargins:NO];
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    
    NSInteger i = indexPath.row % 11;
    NSString *imageName = [NSString stringWithFormat:@"image%@.jpg", @(i)];
    UIImage *image = [UIImage imageNamed:imageName];
    
    if ([cell.imgView1 respondsToSelector:@selector(setImage:)]) {
        [cell.imgView1 performSelector:@selector(setImage:) withObject:image];
    }
    if ([cell.imgView2 respondsToSelector:@selector(setImage:)]) {
        [cell.imgView2 performSelector:@selector(setImage:) withObject:image];
    }
    if ([cell.imgView3 respondsToSelector:@selector(setImage:)]) {
        [cell.imgView3 performSelector:@selector(setImage:) withObject:image];
    }
    return cell;
}

@end
