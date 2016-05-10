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
    UIImage *image = [UIImage imageNamed:@"conan1"];
    _layer.frame = CGRectMake(10.0, 64.0, image.size.width, image.size.height);
    _layer.contents = (__bridge id)image.CGImage ;
    [self.view.layer addSublayer:_layer] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tapClick:(UITapGestureRecognizer *)gr {
    CGPoint p2 = CGPointMake(300.0, 300.0) ;
    CABasicAnimation *basicAni = [[CABasicAnimation alloc] init] ;
    basicAni.keyPath = @"position" ;
    basicAni.toValue = [NSValue valueWithCGPoint:p2] ;
    basicAni.autoreverses = YES ;
    basicAni.repeatCount = 1.0 ;
    basicAni.duration = 1.0 ;
    [_layer addAnimation:basicAni forKey:@"basic"] ;
    _layer.position = p2;
}

@end
