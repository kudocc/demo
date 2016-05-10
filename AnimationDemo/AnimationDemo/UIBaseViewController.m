//
//  UIBaseViewController.m
//  AnimationDemo
//
//  Created by yuanrui on 15/4/27.
//  Copyright (c) 2015年 KudoCC. All rights reserved.
//

#import "UIBaseViewController.h"

@interface UIBaseViewController ()

@property (nonatomic, strong) CALayer *layerTips;

@end

@implementation UIBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *string = @"Tap触发动画";
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:14.0], NSForegroundColorAttributeName:[UIColor blueColor]};
    CGRect bounding = [string boundingRectWithSize:CGSizeMake(1024, 30.0) options:0 attributes:attribute context:nil];
    CGSize size = CGSizeMake(ceil(bounding.size.width), ceil(bounding.size.height));
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [string drawAtPoint:CGPointMake(0, 0) withAttributes:attribute];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    _layerTips = [[CALayer alloc] init];
    
    
    _layerTips.contents = (__bridge id)image.CGImage;
    [self.view.layer addSublayer:_layerTips];
    _layerTips.frame = CGRectMake(0, 0, size.width, size.height);
    _layerTips.position = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)] ;
    [self.view addGestureRecognizer:tap] ;
}

- (void)tapClick:(UITapGestureRecognizer *)gr
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
