//
//  CABasicAnimationTestViewController.m
//  AnimationDemo
//
//  Created by yuanrui on 15/4/27.
//  Copyright (c) 2015年 KudoCC. All rights reserved.
//

#import "CABasicAnimationTestViewController.h"

@interface CABasicAnimationTestViewController ()

@property (nonatomic, strong) CALayer *layer ;

@end

@implementation CABasicAnimationTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _layer = [[CALayer alloc] init] ;
    _layer.frame = CGRectMake(10.0, 64.0, 170.0, 179.0) ;
    UIImage *image = [UIImage imageNamed:@"conan1.png"] ;
    _layer.contents = (__bridge id)image.CGImage ;
    [self.view.layer addSublayer:_layer] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tapClick:(UITapGestureRecognizer *)gr
{
    CGPoint p1 = CGPointMake(30.0, 30.0) ;
    CGPoint p2 = CGPointMake(300.0, 300.0) ;
    CABasicAnimation *basicAni = [[CABasicAnimation alloc] init] ;
    basicAni.keyPath = @"position" ;
    basicAni.fromValue = [NSValue valueWithCGPoint:p1] ;
    basicAni.toValue = [NSValue valueWithCGPoint:p2] ;
    basicAni.autoreverses = YES ;
    basicAni.repeatCount = 1.0 ;
    basicAni.duration = 1.0 ;
    [_layer addAnimation:basicAni forKey:@"basic"] ;
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
